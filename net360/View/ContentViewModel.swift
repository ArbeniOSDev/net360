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
    
    init() {
        self.events = (0..<5).map { id in
            Event(id: id, name: "Event \(id)", count: Int.random(in: 1...10))
        }
    }
}

struct Event: Identifiable {
    let id: Int
    let name: String
    let count: Int
}
