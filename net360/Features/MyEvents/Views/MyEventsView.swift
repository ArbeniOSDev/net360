//
//  MyEventsView.swift
//  net360
//
//  Created by Arben on 23.7.24.
//

import SwiftUI

struct MyEventsView: View {
    @StateObject var taskModel: TaskViewModel = TaskViewModel()
    @Namespace var animation
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.bgColor
                    .ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false) {
                    HeaderView()
                    TasksView()
                }
            }
        }
    }
    
    // MARK: Tasks View
    func TasksView()->some View{
        LazyVStack(spacing: 15){
            if let tasks = taskModel.filteredTasks{
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
        .onChange(of: taskModel.currentDay) { newValue in
            taskModel.filterTodayTasks()
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
                        DescText(task.taskDescription, 14, color: .gray.opacity(0.8))
                    }.hLeading()
                    DescText(task.taskDate.formatted(date: .omitted, time: .shortened), 18)
                }
                
                if taskModel.isCurrentHour(date: task.taskDate){
                    // MARK: Team Members
                    HStack(spacing: 0){
                        HStack(spacing: -10){
                            ForEach(["User1","User2","User3"],id: \.self){user in
                                Image(user)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 42, height: 42)
                                    .clipShape(Circle())
                                    .background(
                                        Circle()
                                            .stroke(.black,lineWidth: 3))
                            }
                        }.hLeading()
                        Button {
                        } label: {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.white)
                                .padding(7)
                                .background(Color(hex: "#00A3FF"), in: RoundedRectangle(cornerRadius: 5))
                        }
                    }.padding(.top)
                }
            }
            .foregroundColor(taskModel.isCurrentHour(date: task.taskDate) ? .white : .black)
            .padding(taskModel.isCurrentHour(date: task.taskDate) ? 15 : 0)
            .padding(.bottom,taskModel.isCurrentHour(date: task.taskDate) ? 0 : 10)
            .hLeading()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.3), radius: 2, x: 0, y: 0)
                .padding(1)
        }
        .hLeading()
    }
    
    // MARK: Header
    func HeaderView()->some View{
        HStack(spacing: 10){
            VStack(alignment: .leading, spacing: 10) {
                DescText(Date().formatted(date: .abbreviated, time: .omitted), color: .gray)
                DescText("Today", 22).bold()
            }
            .hLeading()
            Button {
            } label: {
                Image("User1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            }
        }
        .padding()
        .background(Color.bgColor)
    }
}

struct MyEventsView_Previews: PreviewProvider {
    static var previews: some View {
        MyEventsView()
    }
}
