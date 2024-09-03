//
//  ContentView.swift
//  net360
//
//  Created by Arben on 17.7.24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var authManager: LoginViewModel
    @StateObject var taskViewModel = TaskViewModel()
    @StateObject var viewModel = ContentViewModel()
    @StateObject var eventViewModel = EventViewModel()
    @State private var sliderBackgroundColor: Color = .customBlueColor
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.customBlueColor)
       UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
       }
    
    var filteredEvents: [Event1] {
        let events = viewModel.sortedEvents(by: viewModel.selectedItem)
        if viewModel.search.isEmpty {
            return events
        } else {
            return events.filter { $0.title?.localizedCaseInsensitiveContains(viewModel.search) == true }
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
                            SearchBar(text: $viewModel.search)
                            Menu {
                                Picker(selection: $viewModel.selectedItem) {
                                    ForEach(viewModel.menuItems, id: \.self) { value in
                                        DescText(value, 14, color: Color.buttonColor)
                                            .tag(value)
                                    }
                                } label: {}
                            } label: {
                                HStack {
                                    DescText(viewModel.selectedItem, 14, color: Color.buttonColor)
                                    Image("arrows")
                                        .customImageModifier(width: 14, renderingMode: .template, color: Color.buttonColor, aspectRatio: .fit)
                                }.foregroundColor(.blue)
                            }.id(viewModel.selectedItem)
                        }
                        Divider()
                    }.horizontalPadding(20)
                    ScrollView {
                        VStack(spacing: 15) {
                            VStack(alignment: .leading) {
                                SubTextBold("Today's events", 24).horizontalPadding(20)
                                PointerView().horizontalPadding(20)
                                TabView {
                                if let tickets = ticketsForEventType() {
                                    ForEach(tickets.indices.prefix(2), id: \.self) { index in
                                        AllEventsTicketCell(
                                            ticket: tickets[index],
                                            isSelected: true,
                                            showOverlayList: $eventViewModel.showOverlay,
                                            selectedIndex: 0, index: index,
                                            onSelect: { id, _ in
                                            }, eventType: eventViewModel.newsSelectedSegment == 0 ? .public : .private, coverSelect: { id in
                                            }
                                        ).verticalPadding(5).topPadding(3).horizontalPadding(-17)
                                            .onTapGesture {
                                                eventViewModel.selectedCellID = index
                                                setupOverlayState(for: tickets[index])
                                                eventViewModel.showSheet = true
                                            }
                                            .onChange(of: eventViewModel.selectedCellID) { newValue in
                                                if newValue == index {
                                                    setupOverlayState(for: tickets[index])
                                                }
                                            }
                                            .onChange(of: eventViewModel.showOverlay) { newValue in
                                                if newValue {
                                                    eventViewModel.selectedCellID = tickets[index].id ?? 0
                                                }
                                            }
                                    }.horizontalPadding()
                                        .topPadding(-25)
                                }
                            }.tabViewStyle(PageTabViewStyle())
                                    .frame(height: 260)
                                SubTextBold("All events", 24)
                                    .horizontalPadding(20)
                            }
                            HStack(alignment: .center, spacing: 25) {
                                Spacer()
                                HStack (spacing: 20) {
                                    ForEach(viewModel.years, id: \.self) { year in
                                        Button {
                                            viewModel.selectedYear = "\(year)"
                                        } label: {
                                            DescText("\(year)", 16, color: viewModel.selectedYear == "\(year)" ? .blue : .gray)
                                        }
                                    }
                                }
                                Spacer()
                            }.topPadding(5)
                            ForEach(filteredEvents) { event in
                                NewEventCellView(event: event)
                            }.horizontalPadding(20)
                        }
                    }
                }
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
                            .customImageModifier(width: 26, renderingMode: .template, color: Color.buttonColor, aspectRatio: .fit)
                    }
                }
            }).navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $eventViewModel.showSheet) {
                    OverlayView(
                        selectedCellID: eventViewModel.selectedCellID,
                        slideStartTime: $eventViewModel.slideStartTime,
                        slideEndTime: $eventViewModel.slideEndTime,
                        isFirstSlide: $eventViewModel.isFirstSlide,
                        slideCompletedTwice: $eventViewModel.slideCompletedTwice,
                        sliderBackgroundColor: $sliderBackgroundColor,
                        sliderText: $eventViewModel.sliderText,
                        taskViewModel: taskViewModel
                    )
                    .presentationDetents([.height(230)])
                    .onDisappear {
                        // call API again when the sheet will dissapear
                        //                taskViewModel.fetchData()
                    }
                }
                .sheet(isPresented: $eventViewModel.showOverlay) {
                    TeamEventListView(selectedCellID: $eventViewModel.selectedCellID)
                }
        }
    }
    
    struct OverlayView: View {
        let selectedCellID: Int
        @Binding var slideStartTime: String
        @Binding var slideEndTime: String
        @Binding var isFirstSlide: Bool
        @Binding var slideCompletedTwice: Bool
        @Binding var sliderBackgroundColor: Color
        @Binding var sliderText: String
        @ObservedObject var taskViewModel: TaskViewModel
        
        var body: some View {
            VStack {
                if isEventScheduledForToday() {
                    HStack(spacing: 32) {
                        VStack {
                            if !isFirstSlide {
                                DescText("Start time", 16, color: .black)
                                SubTextBold("\(slideStartTime)", 26, .bold, color: .black)
                                    .frame(height: 20)
                            }
                        }
                        if slideCompletedTwice {
                            VStack {
                                DescText("End time", 16, color: .black)
                                SubTextBold("\(slideEndTime)", 26, .bold, color: .black)
                                    .frame(height: 20)
                            }
                        }
                    }.padding(.bottom, 15)
                    if !slideCompletedTwice {
                        SliderButton(
                            onComplete: {
                                let currentTime = MainEventsView.getCurrentTime()
                                
                                switch (isFirstSlide, slideCompletedTwice) {
                                case (true, false):
                                    // First case: Event not started
                                    slideStartTime = currentTime
                                    sliderBackgroundColor = .red
                                    sliderText = "Slide to finish"
                                    taskViewModel.updateTicket(at: selectedCellID, withStartTime: slideStartTime)
                                    isFirstSlide = false
                                    // call API for the start time
                                    //                                    taskViewModel.startTimingAPI()
                                    
                                case (false, false):
                                    // Second case: Event started but not ended
                                    slideEndTime = currentTime
                                    slideCompletedTwice = true
                                    sliderBackgroundColor = .blue
                                    sliderText = "Completed"
                                    taskViewModel.updateTicket(at: selectedCellID, withEndTime: slideEndTime)
                                    // call API for the end time
                                    //                                    taskViewModel.endTimingAPI()
                                default:
                                    break
                                }
                            },
                            text: sliderText,
                            backgroundColor: sliderBackgroundColor
                        )
                    } else {
                        VStack(spacing: 8) {
                            Image("successTickIcon")
                                .resizable()
                                .frame(width: 60, height: 60)
                            SubText("You have completed the event", 16, color: .black)
                            SubText("Total time: \(calculateTotalTime())", 16, color: .black).bold()
                        }
                    }
                } else {
                    VStack(spacing: 22) {
                        Image(systemName: "calendar.badge.exclamationmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.customBlueColor)
                            .frame(width: 60)
                        SubText("This event is not scheduled for today.", 18, color: .black)
                            .bold()
                    }
                    .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
        }
        
        private func calculateTotalTime() -> String {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "hh:mm a"
            
            guard let start = timeFormatter.date(from: slideStartTime),
                  let end = timeFormatter.date(from: slideEndTime) else {
                return "0 hours and 0 min"
            }
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: start, to: end)
            let hours = components.hour ?? 0
            let minutes = components.minute ?? 0
            
            return "\(hours) hours and \(minutes) min"
        }
        
        private func isEventScheduledForToday() -> Bool {
            guard let tickets = taskViewModel.myEventsDetailsObject?.tickets,
                  selectedCellID < tickets.count else {
                return false
            }
            
            let eventDateString = tickets[selectedCellID].date?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd yyyy"
            
            // Get current year
            let currentYear = Calendar.current.component(.year, from: Date())
            
            // Combine the date and year
            let fullDateString = "\(eventDateString ?? "") \(currentYear)"
            
            if let eventDate = formatter.date(from: eventDateString ?? "") {
                let calendar = Calendar.current
                var components = calendar.dateComponents([.year, .month, .day], from: eventDate)
                components.year = currentYear
                
                if let updatedEventDate = calendar.date(from: components) {
                    return Calendar.current.isDateInToday(updatedEventDate)
                } else {
                    print("Failed to update event date with current year")
                }
            } else {
                print("Failed to parse date: \(fullDateString)")
            }
            return false
        }
    }
    
    private func setupOverlayState(for ticket: Details) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "hh:mm a"

        if let startTime = ticket.startingTime,
           let startTimeDate = timeFormatter.date(from: startTime) {
            eventViewModel.slideStartTime = displayFormatter.string(from: startTimeDate)
        } else {
            eventViewModel.slideStartTime = ""
        }
        
        if let endTime = ticket.endedTime,
           let endTimeDate = timeFormatter.date(from: endTime) {
            eventViewModel.slideEndTime = displayFormatter.string(from: endTimeDate)
        } else {
            eventViewModel.slideEndTime = ""
        }
        
        eventViewModel.isFirstSlide = !(ticket.hasStartedEvent ?? false)
        eventViewModel.slideCompletedTwice = ticket.hasEndedEvent ?? false
        
        if ticket.hasStartedEvent == true && ticket.hasEndedEvent == false {
            sliderBackgroundColor = .red
            eventViewModel.sliderText = "Slide to finish"
        } else if ticket.hasEndedEvent == true {
            sliderBackgroundColor = .blue
            eventViewModel.sliderText = "Completed"
        } else {
            sliderBackgroundColor = .customBlueColor
            eventViewModel.sliderText = "Slide to start"
        }
    }
    
    func ticketsForEventType() -> [Details]? {
        switch viewModel.eventType {
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
