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
    @State private var showAlert: Bool = false
    @State private var showOverlay: Bool = false
    @State private var selectedCellID: Int = 0
    var cityName: String?
    var eventName: String?
    @State private var selectedDate: String? = nil
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.bgColor
                .ignoresSafeArea()
            VStack(spacing: 15) {
                CustomSegmentedPickerView(selectedIndex: $selectedIndex)
                    .horizontalPadding(25)
                ScrollView {
                    if let tickets = viewModel.detailsEventObject?.tickets {
                        ForEach(tickets.indices, id: \.self) { index in
                            TicketCell(
                                ticket: tickets[index],
                                cityName: cityName,
                                eventName: eventName ?? "",
                                isSelected: selectedIndex == 1 ? true : selectedCellID == tickets[index].id,
                                showOverlayList: $showOverlay,
                                selectedIndex: selectedIndex,
                                index: index,
                                onSelect: { id, date in
                                    if selectedIndex == 0 {
                                        selectedCellID = id
                                        selectedDate = date
                                    }
                                }, eventType: selectedIndex == 0 ? .public : .private
                            ).verticalPadding()
                                .onTapGesture {
                                    if selectedIndex == 0 {
                                        showAlert = true
                                    }
                                }
                        }
                    } else if viewModel.noDataAvailable {
                        Text("No tickets available")
                            .padding()
                    }
                }
            }
        }
        .sheet(isPresented: $showOverlay) {
            TeamEventListView(selectedCellID: $selectedCellID)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Do you want to make appointment?"),
                message: Text("To the \(eventName ?? "") event in \(cityName ?? "") on \(convertDateFormat(dateString: selectedDate ?? "23 August")) 2024"),
                primaryButton: .destructive(Text("OK")) {
                },
                secondaryButton: .cancel())
        }
    }
    
    func convertDateFormat(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd" // Input format
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd MMMM" // Output format
            return dateFormatter.string(from: date)
        }
        
        return dateString // Return original string if conversion fails
    }
}

struct DetailsEventListView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsEventListView()
    }
}
