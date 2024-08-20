//
//  MyEventsView.swift
//  net360
//
//  Created by Arben on 23.7.24.
//

import SwiftUI

struct MyEventsView: View {
    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()
    @State private var selectedCellID: Int = 0
    @State private var showOverlay: Bool = false
    @State private var selectedIndex = 0
    @State private var slideStartTime: String = ""
    @State private var slideEndTime: String = ""
    @State private var isFirstSlide = true
    @State private var showSheet = false
    @State private var slideCompletedTwice = false
    @State private var sliderBackgroundColor: Color = .customBlueColor
    @State private var sliderText: String = "Slide to start"
    @State private var newsSelectedSegment = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.bgColor
                    .ignoresSafeArea()
                VStack {
                    HeaderView()
                    CustomSegmentedPickerView(selectedIndex: $newsSelectedSegment, titles: taskViewModel.segmentTitles)
                        .horizontalPadding()
                    PointerView()
                    TaskView()
                }
            }
            .onAppear {
                if selectedCellID < taskViewModel.detailsEventObject?.tickets?.count ?? 0 {
                    setupOverlayState(for: taskViewModel.detailsEventObject!.tickets![selectedCellID])
                }
            }
        }
    }
    
    private func setupInitialSelection() {
        if let firstTicket = taskViewModel.detailsEventObject?.tickets?.first {
            selectedCellID = 0
            setupOverlayState(for: firstTicket)
        }
    }
    
    func PointerView() -> some View {
        HStack(spacing: 8) {
            Image("pointerIcon")
                .resizable()
                .frame(width: 25, height: 25)
            DescText("Click an event to start timing", 16, color: .black)
            Spacer()
        }.horizontalPadding(20).topPadding()
    }
    
    func TaskView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                if let tickets = taskViewModel.detailsEventObject?.tickets {
                    ForEach(tickets.indices, id: \.self) { index in
                        TicketCell(
                            ticket: tickets[index],
                            isSelected: true,
                            showOverlayList: $showOverlay,
                            selectedIndex: selectedCellID,
                            index: index,
                            onSelect: { id in
                                selectedCellID = id
                            }
                        ).verticalPadding()
                            .onTapGesture {
                                selectedCellID = index
                                setupOverlayState(for: tickets[index])
                                showSheet = true
                            }
                    }
                }
            }.horizontalPadding()
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
    }
    
    private func setupOverlayState(for ticket: Details) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
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
                if isEventScheduledForToday() {
                    HStack(spacing: 32) {
                        VStack {
                            DescText("Start time", 16, color: .black)
                            SubTextBold("\(slideStartTime)", 26, .bold, color: .black)
                                .frame(height: 20)
                        }
                        VStack {
                            DescText("End time", 16, color: .black)
                            SubTextBold("\(slideEndTime)", 26, .bold, color: .black)
                                .frame(height: 20)
                        }
                    }.padding(.bottom, 15)
                    
                    if !slideCompletedTwice {
                        SliderButton(
                            onComplete: {
                                let currentTime = MyEventsView.getCurrentTime()
                                
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
            timeFormatter.dateFormat = "hh:mm a" // Assuming the times are in "hh:mm a" format
            
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
            guard let tickets = taskViewModel.detailsEventObject?.tickets,
                  selectedCellID < tickets.count else {
                return false
            }
            
            let eventDateString = tickets[selectedCellID].date?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd"
            
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
                        ForEach(["User1","User2","User3"],id: \.self){user in
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
                Image("User1")
                    .resizable()
                    .imageCircleModifier(height: 45, width: 45, renderingMode: .original, color: .clear, aspectRatio: .fill, colorStroke: .clear, lineWidth: 0.1)
            }
        }
        .padding()
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
        MyEventsView()
    }
}
