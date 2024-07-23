//
//  DetailsEventListViewModel.swift
//  net360
//
//  Created by Arben on 19.7.24.
//

import Foundation

class DetailsEventListViewModel: ObservableObject {
    @Published var selectedValue = ""
    @Published var dropDownList = ["Visar Ademi", "Diellza Aliji", "Peter Funke", "Gzim Hasani", "Mergime Reci"]
    @Published var shouldShowDropDown: Bool = false
    
    let tickets: [Ticket] = [
        Ticket(from: "Basel", to: "New Zealand", time: "10:00 - 10:30", bookingID: "2h 0m", price: "300 MYR", date: "AUG\n04", year: "2024"),
        Ticket(from: "Zurich", to: "New Zealand", time: "12:00 - 13:30", bookingID: "2h 0m", price: "300 MYR", date: "SEP\n04", year: "2024"),
        Ticket(from: "Geneva", to: "New Zealand", time: "13:00 - 14:30", bookingID: "2h 0m", price: "300 MYR", date: "MAR\n04", year: "2024"),
        Ticket(from: "Bern", to: "New Zealand", time: "09:00 - 11:30", bookingID: "2h 0m", price: "available 4", date: "JUN\n04", year: "2024"),
    ]
}
