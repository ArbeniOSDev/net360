//
//  DetailsEventModel.swift
//  net360
//
//  Created by Arben on 5.8.24.
//

import SwiftUI

struct DetailsEventModel: Codable {
    let tickets: [Details]?
}

// MARK: - Ticket
struct Details: Codable {
    let id: Int?
    let from, to, time, bookingID, price, date, year: String?
}
