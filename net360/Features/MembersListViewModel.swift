//
//  MembersListViewModel.swift
//  net360
//
//  Created by Arben on 3.9.24.
//

import SwiftUI
import Combine

class MembersListViewModel: ObservableObject {
    private let apiService: APIServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    @Published var membersId: [Int] = []
    @Published var eventId: Int = 0
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func updatePersonalData() {
        isLoading = true
        let params: [String: Any] = [
            "membersId": membersId,
            "eventId": eventId
        ]
        apiService.request(.detailsEvent, method: .post, parameters: params, headers: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.isLoading = false
                case .failure(let error):
                    self?.isLoading = false
                    self?.error = error
                }
            }, receiveValue: { [weak self] (userObject: UserResponse?) in
//                self?.userObject = userObject
                print("")
            })
            .store(in: &cancellables)
    }
}
