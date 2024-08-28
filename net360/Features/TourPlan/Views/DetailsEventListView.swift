//
//  DetailsEventListView.swift
//  net360
//
//  Created by Arben on 19.7.24.
//

import SwiftUI

struct DetailsEventListView: View {
    @StateObject var viewModel = DetailsEventListViewModel()
    var eventType: EventType
    @State private var selectedIndex = 0
    @State private var showAlert: Bool = false
    @State private var showOverlay: Bool = false
    @State private var selectedCellID: Int = 0
    var cityName: String?
    var eventName: String?
    @State private var selectedDate: String? = nil
    @State private var isCellSelected: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.bgColor
                .ignoresSafeArea()
            VStack(spacing: 15) {
//                if eventType == .future {
//                    CustomSegmentedPickerView(selectedIndex: $selectedIndex)
//                        .horizontalPadding(25)
//                }
                ScrollView {
                    if let tickets = viewModel.detailsEventObject?.tickets {
                        ForEach(tickets.indices, id: \.self) { index in
                            AllEventsTicketCell(
                                ticket: tickets[index],
                                cityName: cityName,
                                eventName: eventName ?? "",
                                isSelected: eventType == .future ? selectedIndex == 0 ? isCellSelected && selectedCellID == tickets[index].id : selectedCellID == tickets[index].id : true,
                                showOverlayList: $showOverlay,
                                selectedIndex: selectedIndex,
                                index: index,
                                onSelect: { id, date in
                                    if eventType == .future {
                                        if selectedIndex == 0 {
                                            selectedCellID = id
                                            selectedDate = date
                                            showAlert = true
                                        }
                                    }
                                },
                                eventType: eventType == .future ? .public : .private,
                                cellIsClosed: true
                            )
                            .topPadding()
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
                message: Text("To the \(eventName ?? "") event in \(cityName ?? "") on \(convertDateFormat(dateString: selectedDate ?? "23 August"))"),
                primaryButton: .default(Text("OK")) {
                    isCellSelected.toggle()
                },
                secondaryButton: .cancel())
        }
    }
    
    func convertDateFormat(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd MMMM"
            return dateFormatter.string(from: date)
        }
        
        return dateString
    }
}
