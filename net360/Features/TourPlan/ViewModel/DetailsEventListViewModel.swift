//
//  DetailsEventListViewModel.swift
//  net360
//
//  Created by Arben on 19.7.24.
//

import Foundation
import Combine

class DetailsEventListViewModel: ObservableObject {
    @Published var detailsEventObject: DetailsEventModel?
    private let apiService: APIServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    @Published var selectedValue = ""
    @Published var dropDownList = ["Visar Ademi", "Diellza Aliji", "Peter Funke", "Gzim Hasani", "Mergime Reci"]
    @Published var shouldShowDropDown: Bool = false
    @Published var noDataAvailable: Bool = false
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        
        fetchData()
    }
    
    func fetchData() {
        isLoading = true
        apiService.request(.detailsEvent, method: .get, parameters: nil, headers: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.isLoading = false
                case .failure(let error):
                    self?.isLoading = false
                    self?.error = error
                    self?.noDataAvailable = true
                }
            }, receiveValue: { [weak self] (detailsEventObject: DetailsEventModel?) in
                self?.detailsEventObject = detailsEventObject
                if detailsEventObject?.tickets == nil {
                    self?.noDataAvailable = true
                }
            })
            .store(in: &cancellables)
    }
    
    func getSelectedTicketFromField(selectedCellID: Int?) -> String {
        guard let id = selectedCellID,
              let ticket = detailsEventObject?.tickets?.first(where: { $0.id == id }),
              let fromField = ticket.from else {
            return ""
        }
        return fromField
    }
    
    let tickets: [Ticket] = [
        Ticket(from: "Basel", to: "New Zealand", time: "10:00 - 10:30", bookingID: "2h 0m", price: "300 MYR", date: "AUG\n04", year: "2024"),
        Ticket(from: "Zurich", to: "New Zealand", time: "12:00 - 13:30", bookingID: "2h 0m", price: "300 MYR", date: "SEP\n04", year: "2024"),
        Ticket(from: "Geneva", to: "New Zealand", time: "13:00 - 14:30", bookingID: "2h 0m", price: "300 MYR", date: "MAR\n04", year: "2024"),
        Ticket(from: "Bern", to: "New Zealand", time: "09:00 - 11:30", bookingID: "2h 0m", price: "available 4", date: "JUN\n04", year: "2024"),
    ]
}
