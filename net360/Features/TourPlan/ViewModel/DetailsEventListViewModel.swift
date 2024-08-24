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
    @Published var dropDownList = ["Fisnik Sadiki", "Diellza Aliji", "Peter Funke", "Gzim Hasani", "Mergime Reci"]
    @Published var shouldShowDropDown: Bool = false
    @Published var noDataAvailable: Bool = false
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        
        setDummyData()
    }
    
    func setDummyData() {
        self.detailsEventObject = DetailsEventModel(
            tickets: [
                Details(
                    id: 1,
                    from: "Basel",
                    to: "New Zealand",
                    time: "10:00 - 10:30",
                    price: "300 MYR",
                    date: "AUG 26 2024",
                    year: "2024"
                ),
                Details(
                    id: 2,
                    from: "Zurich",
                    to: "New Zealand",
                    time: "12:00 - 13:30",
                    price: "300 MYR",
                    date: "AUG 26 2024",
                    year: "2024"
                ),
                Details(
                    id: 3,
                    from: "Geneva",
                    to: "New Zealand",
                    time: "13:00 - 14:30",
                    price: "300 MYR",
                    date: "AUG 27 2024",
                    year: "2024"
                ),
                Details(
                    id: 4,
                    from: "Bern",
                    to: "New Zealand",
                    time: "09:00 - 11:30",
                    price: "available 4",
                    date: "AUG 28 2024",
                    year: "2024"
                )
            ]
        )
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
