//
//  MyEventsView.swift
//  net360
//
//  Created by Arben on 23.7.24.
//

import SwiftUI

struct MyEventsView: View {
    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()
    @State private var selectedCellID: Int? = nil
    @State private var showOverlay: Bool = false
    @State private var selectedIndex = 0
    @State private var slideStartTime: String? = nil
    @State private var slideEndTime: String? = nil
    @State private var isFirstSlide = true
    @State private var navigateToProfileView: Bool = false
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.bgColor
                    .ignoresSafeArea()
                VStack {
                    HeaderView()
                    TaskView()
                }
                
                if showOverlay {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                    
                    if let selectedCellID = selectedCellID {
                        OverlayView(selectedCellID: selectedCellID)
                            .edgesIgnoringSafeArea(.all)
                            .padding(20)
                    }
                }
            }
        }
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
                            selectedIndex: selectedIndex,
                            index: index,
                            onSelect: { id in
                                selectedCellID = selectedCellID == id ? nil : id
                            }
                        ).verticalPadding()
                            .onTapGesture {
                                selectedCellID = index
                                showSheet.toggle()
//                                showOverlay = true
                            }
                    }
                }
            }.horizontalPadding()
        }
        .sheet(isPresented: $showSheet) {
//            Text("This is the expandable bottom sheet.")
//            if let selectedCellID = selectedCellID {
                OverlayView(selectedCellID: selectedCellID ?? 0)
//                    .edgesIgnoringSafeArea(.all)
//                    .padding(20)
//            }
                .presentationDetents([.height(200), .medium, .large])
        }
    }
    
    func OverlayView(selectedCellID: Int) -> some View {
            VStack {
                HStack(spacing: 32) {
                    VStack {
                        DescText("Start time", 16, .bold, color: .black)
                        SubTextBold("\(slideStartTime ?? "")", 26, .bold, color: .black)
                            .frame(height: 20)
                    }
                    VStack {
                        DescText("End time", 16, .bold, color: .black)
                        SubTextBold("\(slideEndTime ?? "")", 26, .bold, color: .black)
                            .frame(height: 20)
                    }
                }.bottomPadding(15)
                
                SliderButton(onComplete: {
                    if isFirstSlide {
                        slideStartTime = getCurrentTime()
                        isFirstSlide = false
                    } else {
                        slideEndTime = getCurrentTime()
                    }
                })
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
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
//        .padding(.top)
        // MARK: Updating Tasks
        .onChange(of: taskViewModel.currentDay) { newValue in
            taskViewModel.filterTodayTasks()
        }
    }
    
    // MARK: Task Card View
    func TaskCardView(task: Task)->some View{
        HStack(alignment: .top,spacing: 30){
//            VStack(spacing: 10){
//                Circle()
//                    .fill(taskModel.isCurrentHour(date: task.taskDate) ? .black : .clear)
//                    .frame(width: 15, height: 15)
//                    .background(
//                        Circle()
//                            .stroke(.black,lineWidth: 1)
//                            .padding(-3))
//                    .scaleEffect(!taskModel.isCurrentHour(date: task.taskDate) ? 0.8 : 1)
//
//                Rectangle()
//                    .fill(.black)
//                    .frame(width: 3)
//            }
//            
            VStack (spacing: 20) {
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 10) {
                        DescText(task.taskTitle, 22).bold()
                        DescText(task.taskDescription, 14)
                    }.hLeading()
                    DescText(task.taskDate.formatted(date: .omitted, time: .shortened), 18)
                }
                
//                if taskModel.isCurrentHour(date: task.taskDate) {
                    // MARK: Team Members
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
//                }
            }
            .foregroundColor(taskViewModel.isCurrentHour(date: task.taskDate) ? .white : .black)
            .padding(taskViewModel.isCurrentHour(date: task.taskDate) ? 15 : 0)
            .padding(.bottom,taskViewModel.isCurrentHour(date: task.taskDate) ? 0 : 10)
            .hLeading()
                .background(Color(hex: "#05a8cc"))
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
            NavigationLink(destination: ProfileSettingsView()) {
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
