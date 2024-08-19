//
//  LoginViewModel.swift
//  net360
//
//  Created by Arben on 22.7.24.
//

import Combine
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var username: String = "api-platform@smzh.ch"
    @Published var password: String = "Qwer123$"
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var userModel: LoginObject?
    @Published var errorMessage: String?
    let placeHolder: String = "I'm looking..."
    @AppStorage("userId") var userId: Int = 0
    @AppStorage("isInitialLoginCompleted") var isInitialLoginCompleted: Bool = false

    private var cancellables: Set<AnyCancellable> = []

    init() {
        checkLoggedIn() // Check login status on initialization
    }

    func saveUserObjectToUserDefaults() {
        guard let userObject = userModel else {
            UserDefaults.standard.removeObject(forKey: "userData")
            return
        }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(userObject) {
            UserDefaults.standard.set(encoded, forKey: "userData")
        }
    }

    func checkLoggedIn() {
        isInitialLoginCompleted = KeychainHelper.shared.read(key: "accessToken") != nil
        if isInitialLoginCompleted {
            loadUserObject()
        }
    }

    func loadUserObject() {
        guard let userDataData = UserDefaults.standard.data(forKey: "userData"),
              let userObject = try? JSONDecoder().decode(LoginObject.self, from: userDataData) else {
            return
        }
        self.userModel = userObject
    }

    func makeLoginAPI() {
        isLoading = true
        guard let url = URL(string: APIConstants.login) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "email": username,
            "password": password
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: LoginObject.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    self.isLoading = false
                    self.showAlert = true
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] loginObject in
                if let token = loginObject.accessToken {
                    _ = KeychainService.shared.save(token: token, forKey: "accessToken")
                    self?.saveUserObjectToUserDefaults()
                    self?.isLoading = false
                    self?.isLoggedIn = true
                    self?.isInitialLoginCompleted = true // Mark initial login as completed
                } else if loginObject.error != "" {
                    self?.isLoading = false
                    self?.showAlert = true
                    self?.errorMessage = loginObject.error ?? ""
                } else {
                    self?.isLoading = false
                    self?.showAlert = true
                    self?.errorMessage = "Server Error"
                }
            })
            .store(in: &cancellables)
    }

    func logout() {
        KeychainHelper.shared.delete(key: "accessToken")
        UserDefaults.standard.removeObject(forKey: "userData")
        userModel = nil
        isLoggedIn = false
        isInitialLoginCompleted = false // Reset initial login status on logout
    }
}

