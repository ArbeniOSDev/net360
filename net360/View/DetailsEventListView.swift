//
//  DetailsEventListView.swift
//  net360
//
//  Created by Arben on 19.7.24.
//

import SwiftUI

struct DetailsEventListView: View {
    @StateObject var viewModel = DetailsEventListViewModel()
    @State private var selectedIndex = 0
    let tickets: [Ticket] = [
        Ticket(from: "Basel", to: "New Zealand", time: "10:00 - 10:30", bookingID: "2h 0m", price: "300 MYR", date: "AUG\n04", year: "2024"),
        Ticket(from: "Zurich", to: "New Zealand", time: "12:00 - 13:30", bookingID: "2h 0m", price: "300 MYR", date: "SEP\n04", year: "2024"),
        Ticket(from: "Geneva", to: "New Zealand", time: "13:00 - 14:30", bookingID: "2h 0m", price: "300 MYR", date: "MAR\n04", year: "2024"),
        Ticket(from: "Bern", to: "New Zealand", time: "09:00 - 11:30", bookingID: "2h 0m", price: "available 4", date: "JUN\n04", year: "2024"),
    ]
    
    var body: some View {
        VStack {
            CustomSegmentedPickerView(selectedIndex: $selectedIndex)
            CustomDropDownView(placeholder: "Select...", selectedValue: $viewModel.selectedValue, value: "", dropDownList: viewModel.dropDownList, shouldShowDropDown: $viewModel.shouldShowDropDown, validate: .date)
        }.horizontalPadding()
        List(tickets) { ticket in
            TicketCell(ticket: ticket)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .verticalPadding()
        }
        .listStyle(PlainListStyle())
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
//                    showOverlayView = true
                }) {
//                    Image(systemName: "square.and.pencil")
                    SubTextBold("Save", 20, color: .blue)
                        .padding()
                }
            }
        }
    }
}

struct DetailsEventListView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsEventListView()
    }
}
