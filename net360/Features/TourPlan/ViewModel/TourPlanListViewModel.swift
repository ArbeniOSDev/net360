//
//  TourPlanListViewModel.swift
//  net360
//
//  Created by Arben on 22.8.24.
//

import Foundation
import Combine

class TourPlanListViewModel: ObservableObject {
    @Published var event: [Event]?
    private let apiService: APIServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    @Published var eventName: String = ""
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        
        fetchDummyDataForEventList()
    }
    
    func fetchDummyDataForEventList() {
        let events: [Event] = [
            Event(id: 1, cityName: "Bern", totalEvents: 6, startDate: "14-08-2024", endDate: "17-08-2024", location: "Allmend", venue: "Venue 1", eventDuration: 3, eventIsForToday: true, daysToStartEvent: 4),
            Event(id: 2, cityName: "Basel", totalEvents: 2, startDate: "12-04-2024", endDate: "15-04-2024", location: "Allmend", venue: "Venue 2", eventDuration: 3, eventIsForToday: false, daysToStartEvent: 7),
            Event(id: 3, cityName: "Zürich", totalEvents: 9, startDate: "02-03-2024", endDate: "06-03-2024", location: "Allmend", venue: "Venue 3", eventDuration: 4, eventIsForToday: true, daysToStartEvent: 9),
            Event(id: 4, cityName: "Aarau", totalEvents: 7, startDate: "27-09-2024", endDate: "30-09-2024", location: "Allmend", venue: "Venue 4", eventDuration: 3, eventIsForToday: false, daysToStartEvent: 11),
            Event(id: 5, cityName: "Lucerne", totalEvents: 5, startDate: "09-08-2024", endDate: "13-08-2024", location: "Allmend", venue: "Venue 5", eventDuration: 4, eventIsForToday: true, daysToStartEvent: 3),
            Event(id: 6, cityName: "Geneva", totalEvents: 5, startDate: "11-08-2024", endDate: "13-08-2024", location: "Allmend", venue: "Venue 6", eventDuration: 2, eventIsForToday: false, daysToStartEvent: 15)
        ]
        event = events
    }
}
