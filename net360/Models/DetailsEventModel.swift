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
    var from, to, title, time, eventTotalTime, price, date, year: String?
    var startingTime, endedTime: String?
    var hasStartedEvent, hasEndedEvent: Bool?
}
