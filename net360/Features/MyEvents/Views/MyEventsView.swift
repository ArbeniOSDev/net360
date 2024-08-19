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
    @State private var navigateToProfileView: Bool = false
    @State private var showSheet = false
    @State private var slideCompletedTwice = false
    @State private var sliderBackgroundColor: Color = .customBlueColor
    @State private var sliderText: String = "Slide to start"
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.bgColor
                    .ignoresSafeArea()
                VStack {
                    HeaderView()
                    PointerView()
                    TaskView()
                }
            }
            .onAppear {
                setupInitialSelection()
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
        }.horizontalPadding()
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
              .presentationDetents([.height(230), .medium, .large])
          }
      }
    
    private func setupOverlayState(for ticket: Details) {
        slideStartTime = ticket.startingTime ?? ""
        slideEndTime = ticket.endedTime ?? ""
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
                                
                            case (false, false):
                                // Second case: Event started but not ended
                                slideEndTime = currentTime
                                slideCompletedTwice = true
                                sliderBackgroundColor = .blue
                                sliderText = "Completed"
                                taskViewModel.updateTicket(at: selectedCellID, withEndTime: slideEndTime)
                                
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
                        SubText("Total time: 2 hours and 30 min", 16, color: .black).bold()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
        }
    }
    
    private func handleSlideCompletion() {
          let currentTime = MyEventsView.getCurrentTime()
          
          switch (isFirstSlide, slideCompletedTwice) {
          case (true, false):
              // First case: Event not started
              slideStartTime = currentTime
              sliderBackgroundColor = .red
              sliderText = "Slide to finish"
              taskViewModel.updateTicket(at: selectedCellID, withStartTime: slideStartTime)
              isFirstSlide = false
              
          case (false, false):
              // Second case: Event started but not ended
              slideEndTime = currentTime
              slideCompletedTwice = true
              sliderBackgroundColor = .blue
              sliderText = "Completed"
              taskViewModel.updateTicket(at: selectedCellID, withEndTime: slideEndTime)
              
          default:
              break
          }
      }
    
    // MARK: Tasks View
    func TasksView()->some View{
        LazyVStack(spacing: 15){
            if let tasks = taskViewModel.filteredTasks{
                if tasks.isEmpty{
                    DescTextLight("No tasks found!!!", 16)
                        .offset(y: 100)
                }
                else {
                    ForEach(tasks){task in
                        TaskCardView(task: task)
                    }
                }
            }
            else {
                ProgressView()
                    .offset(y: 100)
            }
        }
        .padding()
        .onChange(of: taskViewModel.currentDay) { newValue in
            taskViewModel.filterTodayTasks()
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
            .foregroundColor(taskViewModel.isCurrentHour(date: task.taskDate) ? .white : .black)
            .padding(taskViewModel.isCurrentHour(date: task.taskDate) ? 15 : 0)
            .padding(.bottom,taskViewModel.isCurrentHour(date: task.taskDate) ? 0 : 10)
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
    
    func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: Date())
    }
}

struct MyEventsView_Previews: PreviewProvider {
    static var previews: some View {
        MyEventsView()
    }
}
