//
//  ContentView.swift
//  net360
//
//  Created by Arben on 17.7.24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var authManager: LoginViewModel
    @State private var selectedYear: String = "2024"
    @State var search: String = ""
    @StateObject var viewModel = ContentViewModel()
    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()
    @State private var showOverlayView: Bool = false
    @StateObject var eventViewModel = EventViewModel()
    @State private var selectedItem: String = "Availability"
    private let years = Array(2020...2024).reversed()
    private let menuItems = ["Availability", "Alphabet", "Date"]
    var eventType: EventsType = .myEvents
    @State private var newsSelectedSegment = 0
    @State private var showOverlay: Bool = false
    @State private var showAlert = false // State to show the alert
    
    var filteredEvents: [Event1] {
        let events = viewModel.sortedEvents(by: selectedItem)
        if search.isEmpty {
            return events
        } else {
            return events.filter { $0.title?.localizedCaseInsensitiveContains(search) == true }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.bgColor
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        SubTextBold("Kampagnen Liste", (18), color: .black.opacity(0.7))
                            .topPadding()
                        HStack {
                            SearchBar(text: $search)
                            Menu {
                                Picker(selection: $selectedItem) {
                                    ForEach(menuItems, id: \.self) { value in
                                        DescText(value, 14, color: Color.buttonColor)
                                            .tag(value)
                                    }
                                } label: {}
                            } label: {
                                HStack {
                                    DescText(selectedItem, 14, color: Color.buttonColor)
                                    Image("arrows")
                                        .customImageModifier(width: 14, renderingMode: .template, color: Color.buttonColor, aspectRatio: .fit)
                                }.foregroundColor(.blue)
                            }.id(selectedItem)
                        }
                        Divider()
                    }
                    ScrollView {
                        VStack(spacing: 15) {
//                            VStack {
                            HStack {
                                SubTextBold("Today's events", 24)
                                Spacer()
                            }.leadingPadding()
                                if let tickets = ticketsForEventType() {
                                    ForEach(tickets.indices.prefix(1), id: \.self) { index in
                                        TicketCell(
                                            ticket: tickets[index],
                                            isSelected: true,
                                            showOverlayList: $showOverlay,
//                                            selectedIndex: selectedCellID,
                                            selectedIndex: 0, index: index,
                                            onSelect: { id, _ in
                                                //                                                selectedCellID = id
                                            }, eventType: newsSelectedSegment == 0 ? .public : .private, coverSelect: { id in
//                                                selectedCellID = id
                                            }
                                        ).verticalPadding(5).topPadding(3).horizontalPadding(-17)
                                            .onTapGesture {
                                                showAlert = true
//                                                selectedCellID = index
//                                                setupOverlayState(for: tickets[index])
//                                                showSheet = true
                                            }
                                    }
                                }
//                            }
                            HStack {
                                SubTextBold("All events", 24)
                                Spacer()
                            }.leadingPadding().topPadding(5)
                            HStack(alignment: .center, spacing: 25) {
                                Spacer()
                                HStack (spacing: 20) {
                                    ForEach(years, id: \.self) { year in
                                        Button {
                                            selectedYear = "\(year)"
                                        } label: {
                                            DescText("\(year)", 16, color: selectedYear == "\(year)" ? .blue : .gray)
                                        }
                                    }
                                }
                                Spacer()
                            }.topPadding(5)
                            ForEach(filteredEvents) { event in
                                NewEventCellView(event: event)
                            }.horizontalPadding()
                        }
                    }
                }.horizontalPadding(10)
            }.toolbar(content: {
                ToolbarItem(placement: .principal) {
                    Image("smzh-logo2")
                        .customImageModifier(width: 110, renderingMode: .original, color: .mainColor)
                        .if(UIDevice.current.userInterfaceIdiom == .pad) {
                            $0.scaleEffect(1.3)
                        }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddNewKampagneView(viewModel: eventViewModel)) {
                        Image(systemName: "plus.circle.fill")
                            .customImageModifier(width: 22, renderingMode: .template, color: Color.buttonColor, aspectRatio: .fit)
                    }
                }
            }).navigationBarTitleDisplayMode(.inline)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Do you want to appoint to the Zirkus Knie 2024 event?"),
                        message: Text(""),
                        primaryButton: .destructive(Text("OK")) {
                        },
                        secondaryButton: .cancel()
                    )
                }
        }
    }
    
    func ticketsForEventType() -> [Details]? {
        switch eventType {
        case .upcoming:
            return taskViewModel.upcomingDetailsObject?.tickets
        case .myEvents:
            return taskViewModel.myEventsDetailsObject?.tickets
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
