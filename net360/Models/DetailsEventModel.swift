//
//  DetailsEventModel.swift
//  net360
//
//  Created by Arben on 5.8.24.
//

import SwiftUI

struct DetailsEventModel: Codable, Hashable {
    var tickets: [Details]?
}

// MARK: - Ticket
struct Details: Codable, Hashable, Identifiable {
    var id, availablePlaces: Int?
    var from, to, eventName, place, title, time, eventTotalTime, price, date, year: String?
    var startingTime, endedTime: String?
    var hasStartedEvent, hasEndedEvent: Bool?
    var eventMembers: EventMembers?
}

struct EventMembers: Codable, Hashable {
    var name, surname, image: String?
    var isSupervisior: Bool?
}
