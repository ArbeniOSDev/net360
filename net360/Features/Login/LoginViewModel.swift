//
//  LoginViewModel.swift
//  net360
//
//  Created by Arben on 22.7.24.
//

import Combine
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var userObject: UserResponse?
    @Published var error: Error?
    let placeHolder: String = "I'm looking..."
    @AppStorage("userId") var userId: Int = 0
    
    private let apiService: APIServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        checkLoggedIn() // Check login status on initialization
    }
    
    func saveUserObjectToUserDefaults() {
        guard let userObject = userObject else {
            UserDefaults.standard.removeObject(forKey: "userData")
            return
        }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(userObject) {
            UserDefaults.standard.set(encoded, forKey: "userData")
        }
    }
    
    func checkLoggedIn() {
        isLoggedIn = KeychainHelper.shared.read(key: "token") != nil
        if isLoggedIn {
            loadUserObject()
        }
    }
    
    func loadUserObject() {
        guard let userDataData = UserDefaults.standard.data(forKey: "userData"),
              let userObject = try? JSONDecoder().decode(UserResponse.self, from: userDataData) else {
            return
        }
        self.userObject = userObject
    }
    
    func performLogin() {
        saveUserObjectToUserDefaults()
        isLoggedIn = true
        userId = userObject?.userObject?.userId ?? 0
        KeychainHelper.shared.save(key: "password", value: password)
        KeychainHelper.shared.save(key: "token", value: userObject?.token ?? "")
    }
    
    func logout() {
        KeychainHelper.shared.delete(key: "password")
        KeychainHelper.shared.delete(key: "token")
        UserDefaults.standard.removeObject(forKey: "userData")
        isLoggedIn = false
        userObject = nil
    }
}
