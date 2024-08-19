//
//  MyEventsViewModel.swift
//  net360
//
//  Created by Arben on 23.7.24.
//

import SwiftUI
import Combine

class TaskViewModel: ObservableObject {
    private let apiService: APIServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    @Published var detailsEventObject: DetailsEventModel?

    @Published var storedTasks: [Task] = [
         Task(taskTitle: "ZÜRICH", taskDescription: "Meine Ereignisse", taskDate: Date()),
         Task(taskTitle: "THUN", taskDescription: "Meine Ereignisse", taskDate: Date()),
         Task(taskTitle: "ZUG", taskDescription: "Meine Ereignisse", taskDate: Date()),
         Task(taskTitle: "AARAU", taskDescription: "Meine Ereignisse", taskDate: Date()),
         Task(taskTitle: "AARAU", taskDescription: "Meine Ereignisse", taskDate: Date()),
         Task(taskTitle: "LUZERN", taskDescription: "Meine Ereignisse", taskDate: Date()),
         Task(taskTitle: "BERN", taskDescription: "Meine Ereignisse", taskDate: Date()),
         Task(taskTitle: "ZÜRICH", taskDescription: "Meine Ereignisse", taskDate: Date()),
     ]
    
    // MARK: Current Week Days
    @Published var currentWeek: [Date] = []
    
    // MARK: Current Day
    @Published var currentDay: Date = Date()
    
    // MARK: Filtering Today Tasks
    @Published var filteredTasks: [Task]?
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        
        fetchCurrentWeek()
        filterTodayTasks()
//        fetchData()
        generateDummyData()
    }
    
    private func generateDummyData() {
        let tickets = [
            Details(
                id: 1,
                from: "Zurich",
                to: "Los Angeles",
                time: "10:00 AM",
                bookingID: "1234",
                price: "$300",
                date: "AUG\n09",
                year: "2024",
                startingTime: "14:30",
                endedTime: "",
                hasStartedEvent: true,
                hasEndedEvent: false
            ),
            Details(
                id: 2,
                from: "Basel",
                to: "Houston",
                time: "2:00 PM",
                bookingID: "5678",
                price: "$150",
                date: "SEP\n12",
                year: "2024",
                startingTime: "10:31",
                endedTime: "",
                hasStartedEvent: true,
                hasEndedEvent: false
            ),
            Details(
                id: 3,
                from: "Bern",
                to: "Seattle",
                time: "5:30 PM",
                bookingID: "9101",
                price: "$200",
                date: "OCT\n24",
                year: "2024",
                startingTime: "14:30",
                endedTime: "17:00",
                hasStartedEvent: true,
                hasEndedEvent: true
            ),
            Details(
                id: 4,
                from: "Bern",
                to: "Seattle",
                time: "5:30 PM",
                bookingID: "9101",
                price: "$200",
                date: "OCT\n24",
                year: "2024",
                startingTime: "",
                endedTime: "",
                hasStartedEvent: false,
                hasEndedEvent: false
            )
        ]
        detailsEventObject = DetailsEventModel(tickets: tickets)
    }
    
    func updateTicket(at index: Int?, withStartTime startTime: String?) {
        guard let index = index else { return }
        detailsEventObject?.tickets?[index].startingTime = startTime
        detailsEventObject?.tickets?[index].hasStartedEvent = true
    }

    func updateTicket(at index: Int?, withEndTime endTime: String?) {
        guard let index = index else { return }
        detailsEventObject?.tickets?[index].endedTime = endTime
        detailsEventObject?.tickets?[index].hasEndedEvent = true
    }
    
    func fetchData() {
        isLoading = true
        apiService.request(.detailsEvent, method: .get, parameters: nil, headers: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.isLoading = false
                case .failure(let error):
                    self?.isLoading = false
                    self?.error = error
                }
            }, receiveValue: { [weak self] (detailsEventObject: DetailsEventModel?) in
                self?.detailsEventObject = detailsEventObject
            })
            .store(in: &cancellables)
    }
    
    // MARK: Filter Today Tasks
    func filterTodayTasks(){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let calendar = Calendar.current
            
            let filtered = self.storedTasks.filter{
                return calendar.isDate($0.taskDate, inSameDayAs: self.currentDay)
            }
                .sorted { task1, task2 in
                    return task2.taskDate < task1.taskDate
                }
            
            DispatchQueue.main.async {
                withAnimation{
                    self.filteredTasks = filtered
                }
            }
        }
    }
    
    func fetchCurrentWeek(){
        
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else{
            return
        }
        
        (0..<7).forEach { day in
            
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay){
                currentWeek.append(weekday)
            }
        }
    }
    
    // MARK: Extracting Date
    func extractDate(date: Date,format: String)->String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    // MARK: Checking if current Date is Today
    func isToday(date: Date)->Bool{
        
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
    
    // MARK: Checking if the currentHour is task Hour
    func isCurrentHour(date: Date)->Bool{
        
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        
        return hour == currentHour
    }
}
