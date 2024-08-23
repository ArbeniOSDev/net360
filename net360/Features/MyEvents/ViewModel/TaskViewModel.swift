//
//  TaskViewModel.swift
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
    @Published var myEventsDetailsObject: DetailsEventModel?
    @Published var upcomingDetailsObject: DetailsEventModel?

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
    
    @Published var eventNames: [String] = ["Zirkus Knie 2024", "Zugermesse 2024", "OHA 2024", "ZOM 2024", "Winti Mäss 2024"]
    @Published var eventCities: [String] = ["Bern", "Zürich", "Zürich", "Aarau", "Lucerne"]
    @Published var availablePlaces: [Int] = [15, 7, 3, 9, 5]
    
    var upcomingSegmentTitles: [String] = ["Free", "Full"]
    var myEventensSegmentTitles: [String] = ["Public", "Privat"]
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        
        generateDummyDataForMyEvents()
        generateDummyDataForUpcomingEvents()
    }
    
    private func generateDummyDataForMyEvents() {
        let tickets = [
            Details(
                id: 1,
                availablePlaces: 25,
                from: "Bern",
                to: "Los Angeles",
                time: "10:00 AM",
                eventTotalTime: "02:30",
                price: "$300",
                date: "AUG 23 2024",
                year: "2024",
                startingTime: "",
                endedTime: "",
                hasStartedEvent: false,
                hasEndedEvent: false
            ),
            Details(
                id: 2,
                availablePlaces: 15,
                from: "Zürich",
                to: "Houston",
                time: "2:00 PM",
                eventTotalTime: "01:45",
                price: "$150",
                date: "AUG 23 2024",
                year: "2024",
                startingTime: "08:31",
                endedTime: "",
                hasStartedEvent: false,
                hasEndedEvent: false
            ),
            Details(
                id: 3,
                availablePlaces: 3,
                from: "Zürich",
                to: "Seattle",
                time: "5:30 PM",
                eventTotalTime: "03:15",
                price: "$200",
                date: "AUG 23 2024",
                year: "2024",
                startingTime: "",
                endedTime: "",
                hasStartedEvent: false,
                hasEndedEvent: false
            ),
            Details(
                id: 4,
                availablePlaces: 5,
                from: "Aarau",
                to: "Seattle",
                time: "5:30 PM",
                eventTotalTime: "02:15",
                price: "$200",
                date: "OCT 24 2024",
                year: "2024",
                startingTime: "",
                endedTime: "",
                hasStartedEvent: false,
                hasEndedEvent: false
            ),
            Details(
                id: 5,
                availablePlaces: 8,
                from: "Lucerne",
                to: "Seattle",
                time: "5:30 PM",
                eventTotalTime: "03:15",
                price: "$200",
                date: "AUG 21 2024",
                year: "2024",
                startingTime: "",
                endedTime: "",
                hasStartedEvent: false,
                hasEndedEvent: false
            )
        ]
        myEventsDetailsObject = DetailsEventModel(tickets: tickets)
    }
    
    private func generateDummyDataForUpcomingEvents() {
        let tickets = [
            Details(
                id: 1,
                availablePlaces: 25,
                from: "Bern",
                to: "Los Angeles",
                time: "10:00 AM",
                eventTotalTime: "02:30",
                price: "$300",
                date: "MAY 22 2024",
                year: "2024",
                startingTime: "14:30",
                endedTime: "",
                hasStartedEvent: true,
                hasEndedEvent: true
            ),
            Details(
                id: 2,
                availablePlaces: 13,
                from: "Zürich",
                to: "Houston",
                time: "2:00 PM",
                eventTotalTime: "01:45",
                price: "$150",
                date: "AUG 22 2024",
                year: "2024",
                startingTime: "08:31",
                endedTime: "",
                hasStartedEvent: true,
                hasEndedEvent: true
            ),
            Details(
                id: 3,
                availablePlaces: 7,
                from: "Zürich",
                to: "Seattle",
                time: "5:30 PM",
                eventTotalTime: "03:15",
                price: "$200",
                date: "SEP 11 2024",
                year: "2024",
                startingTime: "14:30",
                endedTime: "17:00",
                hasStartedEvent: true,
                hasEndedEvent: true
            ),
            Details(
                id: 4,
                availablePlaces: 17,
                from: "Aarau",
                to: "Seattle",
                time: "5:30 PM",
                eventTotalTime: "02:15",
                price: "$200",
                date: "OCT 24 2024",
                year: "2024",
                startingTime: "",
                endedTime: "",
                hasStartedEvent: true,
                hasEndedEvent: true
            ),
            Details(
                id: 5,
                availablePlaces: 6,
                from: "Lucerne",
                to: "Seattle",
                time: "5:30 PM",
                eventTotalTime: "03:15",
                price: "$200",
                date: "AUG 21 2024",
                year: "2024",
                startingTime: "",
                endedTime: "",
                hasStartedEvent: true,
                hasEndedEvent: true
            )
        ]
        upcomingDetailsObject = DetailsEventModel(tickets: tickets)
    }
    
    func updateTicket(at index: Int?, withStartTime startTime: String?) {
        guard let index = index else { return }
        myEventsDetailsObject?.tickets?[index].startingTime = startTime
        myEventsDetailsObject?.tickets?[index].hasStartedEvent = true
    }

    func updateTicket(at index: Int?, withEndTime endTime: String?) {
        guard let index = index else { return }
        myEventsDetailsObject?.tickets?[index].endedTime = endTime
        myEventsDetailsObject?.tickets?[index].hasEndedEvent = true
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
                self?.myEventsDetailsObject = detailsEventObject
            })
            .store(in: &cancellables)
    }
    
    func startTimingAPI() {
        
    }
    
    func endTimingAPI() {
        
    }
}
