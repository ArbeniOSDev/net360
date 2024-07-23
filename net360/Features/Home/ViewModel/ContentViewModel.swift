//
//  ContentViewModel.swift
//  net360
//
//  Created by Arben on 18.7.24.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var events: [Event]
    @Published var selectedEventID: Int? = nil
    let eventsData = [
        Event1(title: "Zirkus Knie 2024", speaker: "5", hall: "Hall 1"),
        Event1(title: "OHA 2024", speaker: "1", hall: "Hall 2"),
        Event1(title: "ZOM 2024", speaker: "2", hall: "Hall 3"),
        Event1(title: "Zugermesse 2024", speaker: "7", hall: "Hall 4"),
        Event1(title: "Winti Mäss 2024", speaker: "4", hall: "Hall 5")
    ]
    
    init() {
        self.events = (0..<5).map { id in
            Event(id: id, name: "Event \(id ?? 0)", count: Int.random(in: 1...10), location: "", venue: "")
        }
    }
}

struct Event: Identifiable {
    let id: Int?
    let name: String?
    let count: Int?
    let location: String?
    let venue: String?
}
