//
//  MainEventsView.swift
//  net360
//
//  Created by Arben on 23.7.24.
//

import SwiftUI

enum EventsType {
    case upcoming
    case myEvents
}

struct MainEventsView: View {
    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()
    @State private var selectedCellID: Int = 0
    @State private var showOverlay: Bool = false
    @State private var selectedIndex = 0
    @State private var slideStartTime: String = ""
    @State private var slideEndTime: String = ""
    @State private var isFirstSlide = true
    @State private var showSheet = false
    @State private var showAlert = false
    @State private var slideCompletedTwice = false
    @State private var sliderBackgroundColor: Color = .customBlueColor
    @State private var sliderText: String = "Slide to start"
    @State private var newsSelectedSegment = 0
    @State private var selectedTicketIDs: Set<Int> = []
    @State private var selectedTicketID: Int?
    @State private var ticketIDToUpdate: Int?
    @State private var selectedDate: String?
    @State private var selectedEventName: String?
    var eventType: EventsType = .myEvents
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.bgColor
                    .ignoresSafeArea()
                VStack (spacing: 10) {
                    HeaderView().horizontalPadding(25)
                    CustomSegmentedPickerView(selectedIndex: $newsSelectedSegment, titles: eventType == .upcoming ? taskViewModel.upcomingSegmentTitles : taskViewModel.myEventensSegmentTitles).horizontalPadding(25)
                    PointerView().horizontalPadding(25).topPadding(5)
                    TaskView()
                }
            }
            .onAppear {
                if selectedCellID < taskViewModel.myEventsDetailsObject?.tickets?.count ?? 0 {
                    if eventType == .myEvents {
                        setupOverlayState(for: taskViewModel.myEventsDetailsObject!.tickets![selectedCellID])
                    } else {
                        setupOverlayState(for: taskViewModel.upcomingDetailsObject!.tickets![selectedCellID])
                    }
                }
            }
        }
    }
    
    func TaskView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                // my events
                if eventType == .myEvents {
                    if newsSelectedSegment == 0 {
                        if let tickets = ticketsForEventType() {
                            ForEach(tickets.indices, id: \.self) { index in
                                MyEventsCell(
                                    ticket: tickets[index],
                                    cityName: taskViewModel.eventCities[index],
                                    eventName: taskViewModel.eventNames[index],
                                    isSelected: selectedTicketIDs.contains(tickets[index].id ?? 0),
                                    showOverlayList: $showOverlay,
                                    selectedIndex: 0,
                                    index: 0,
                                    onSelect: { id, date, eventName in
                                        ticketIDToUpdate = id
                                        selectedDate = date
                                        selectedEventName = eventName
                                        showAlert = true
                                    },
                                    eventType: .public, newsSelectedSegment: newsSelectedSegment
                                ).topPadding()
                                .onTapGesture {
                                    selectedCellID = index
                                    setupOverlayState(for: tickets[index])
                                    showSheet = true
                                }
                                .onChange(of: selectedCellID) { newValue in
                                    // This triggers a view update when selectedCellID changes
                                    if newValue == index {
                                        setupOverlayState(for: tickets[index])
                                    }
                                }
                            }
                        }
                    } else if newsSelectedSegment == 1 {
                        if let tickets = ticketsForEventType() {
                            ForEach(tickets.indices, id: \.self) { index in
                                MyEventsCell(
                                    ticket: tickets[index],
                                    cityName: taskViewModel.eventCities[index],
                                    eventName: taskViewModel.eventNames[index],
                                    isSelected: false,
                                    showOverlayList: $showOverlay,
                                    selectedIndex: 1,
                                    index: 1,
                                    onSelect: { id, date, eventName in
                                        ticketIDToUpdate = id
                                        selectedDate = date
                                        selectedEventName = eventName
                                    },
                                    eventType: newsSelectedSegment == 0 ? .public : .private, newsSelectedSegment: newsSelectedSegment
                                ).topPadding()
                            }
                        }
                    }
                } else {
                    // upcoming ticket
                    if newsSelectedSegment == 0 {
                        if let tickets = ticketsForEventType() {
                            ForEach(tickets.indices, id: \.self) { index in
                                UpcomingEventCell(
                                    ticket: tickets[index],
                                    cityName: taskViewModel.eventCities[index],
                                    eventName: taskViewModel.eventNames[index],
                                    isSelected: Binding(
                                        get: { selectedTicketIDs.contains(tickets[index].id ?? 0) },
                                        set: { isSelected in
                                            if isSelected {
                                                selectedTicketID = tickets[index].id
                                                showAlert = true
                                            } else {
                                                selectedTicketID = nil
                                            }
                                        }
                                    ),
                                    showOverlayList: $showOverlay,
                                    selectedIndex: 0,
                                    index: index,
                                    onSelect: { _, date, eventName in
                                        selectedDate = date
                                        selectedEventName = eventName
                                    },
                                    eventType: newsSelectedSegment == 0 ? .public : .private,
                                    newsSelectedSegment: newsSelectedSegment
                                ).topPadding()
                            }
                        }
                    } else {
                        if let tickets = ticketsForEventType() {
                            ForEach(tickets.indices, id: \.self) { index in
                                UpcomingEventCell(
                                    ticket: tickets[index],
                                    cityName: taskViewModel.eventCities[index],
                                    eventName: taskViewModel.eventNames[index],
                                    isSelected: .constant(false), // Or whatever condition you want
                                    showOverlayList: $showOverlay,
                                    selectedIndex: 1, // This index should match your logic
                                    index: index, // You can adjust this based on your data
                                    onSelect: { id, date, eventName in
                                        selectedDate = date
                                        selectedEventName = eventName
                                    },
                                    eventType: newsSelectedSegment == 0 ? .public : .private,
                                    newsSelectedSegment: newsSelectedSegment
                                ).topPadding()
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showSheet) {
            OverlayView(
                selectedCellID: selectedCellID,
                slideStartTime: $slideStartTime,
                slideEndTime: $slideEndTime,
                isFirstSlide: $isFirstSlide,
                slideCompletedTwice: $slideCompletedTwice,
                sliderBackgroundColor: $sliderBackgroundColor,
                sliderText: $sliderText,
                taskViewModel: taskViewModel
            )
            .presentationDetents([.height(230)])
            .onDisappear {
                // call API again when the sheet will dissapear
//                taskViewModel.fetchData()
            }
        }
        .sheet(isPresented: $showOverlay) {
            TeamEventListView(selectedCellID: $selectedCellID)
        }
        
        .alert(isPresented: $showAlert) {
            Alert(
                title: eventType == .myEvents ? Text("Do you want to deselect ") : Text("Do you want to appoint "),
                message: eventType == .myEvents ? Text("From the \(selectedEventName ?? "") event in \(selectedDate ?? "")?") : Text("To the \(selectedEventName ?? "") event in \(selectedDate ?? "")?"),
                primaryButton: .default(Text("OK")) {
                    if let ticketID = selectedTicketID {
                        // Update the selection state
                        selectedTicketIDs.insert(ticketID)
                    }
                    if let ticketID = ticketIDToUpdate {
                        // Update the selection state
                        if selectedTicketIDs.contains(ticketID) {
                            selectedTicketIDs.remove(ticketID)
                        } else {
                            selectedTicketIDs.insert(ticketID)
                        }
                    }
                },
                secondaryButton: .cancel())
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
    
    private func setupOverlayState(for ticket: Details) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm a"
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "hh:mm a"

        if let startTime = ticket.startingTime,
           let startTimeDate = timeFormatter.date(from: startTime) {
            slideStartTime = displayFormatter.string(from: startTimeDate)
        } else {
            slideStartTime = ""
        }
        
        if let endTime = ticket.endedTime,
           let endTimeDate = timeFormatter.date(from: endTime) {
            slideEndTime = displayFormatter.string(from: endTimeDate)
        } else {
            slideEndTime = ""
        }
        
        isFirstSlide = !(ticket.hasStartedEvent ?? false)
        slideCompletedTwice = ticket.hasEndedEvent ?? false
        
        if ticket.hasStartedEvent == true && ticket.hasEndedEvent == false {
            sliderBackgroundColor = .red
            sliderText = "Slide to finish"
        } else if ticket.hasEndedEvent == true {
            sliderBackgroundColor = .blue
            sliderText = "Completed"
        } else {
            sliderBackgroundColor = .customBlueColor
            sliderText = "Slide to start"
        }
    }
    
    static func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: Date())
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
                if isEventScheduledForToday(for: selectedCellID) {
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
            timeFormatter.dateFormat = "hh:mm"
            
            guard let start = timeFormatter.date(from: slideStartTime),
                  let end = timeFormatter.date(from: slideEndTime) else {
                return "0 hours and 0 min"
            }
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: start, to: end)
            let hours = components.hour ?? 0
            let minutes = components.minute ?? 0
            
            return "\(hours) hours and \(minutes) min"
        }
        
        private func isEventScheduledForToday(for cellID: Int) -> Bool {
            guard let tickets = taskViewModel.myEventsDetailsObject?.tickets,
                  cellID < tickets.count else {
                return false
            }

            let eventDateString = tickets[cellID].date?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd yyyy"
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            
            if let eventDate = formatter.date(from: eventDateString ?? "") {
                let today = Date()
                formatter.timeZone = TimeZone.current
                
                let todayString = formatter.string(from: today)
                if let todayDate = formatter.date(from: todayString) {
                    return Calendar.current.isDate(eventDate, inSameDayAs: todayDate)
                }
            } else {
                print("Failed to parse date: \(eventDateString ?? "")")
            }
            
            return false
        }
    }
    
    // MARK: Task Card View
    func TaskCardView(task: Task)->some View{
        HStack(alignment: .top,spacing: 30){
            VStack (spacing: 20) {
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 10) {
                        DescText(task.taskTitle, 22).bold()
                        DescText(task.taskDescription, 14)
                    }.hLeading()
                    DescText(task.taskDate.formatted(date: .omitted, time: .shortened), 18)
                }
                
                HStack(spacing: 0){
                    HStack(spacing: -10){
                        ForEach(["User1", "User2", "User3"],id: \.self){user in
                            Image(user)
                                .imageCircleModifier(height: 42, width: 42, renderingMode: .original, color: .clear, aspectRatio: .fill, colorStroke: .black, lineWidth: 3)
                                .background(
                                    Circle().stroke(.black,lineWidth: 3))
                        }
                    }.hLeading()
                    Button {
                    } label: {
                        ImageButton(systemName: "checkmark", padding: 7, hexColor: "#00A3FF")
                    }
                }.padding(.top)
            }
            .hLeading()
            .background(Color.customBlueColor)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.3), radius: 2, x: 0, y: 0)
            .padding(1)
        }
        .hLeading()
    }
    
    // MARK: Header
    func HeaderView()->some View {
        HStack(spacing: 10){
            VStack(alignment: .leading, spacing: 5) {
                DescText(Date().formatted(date: .abbreviated, time: .omitted), color: .gray)
                DescText(getTodayDayName(), 22).bold()
            }
            .hLeading()
            NavigationLink(destination: NewProfileView()) {
                Image("Circle-Fisnik Sadiki")
                    .resizable()
                    .imageCircleModifier(height: 40, width: 40, renderingMode: .original, color: .clear, aspectRatio: .fill, colorStroke: .clear, lineWidth: 0.1)
            }
        }
        .background(Color.bgColor)
    }
    
    func getTodayDayName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: Date())
    }
}

struct MyEventsView_Previews: PreviewProvider {
    static var previews: some View {
        MainEventsView()
    }
}
