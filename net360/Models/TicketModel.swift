//
//  TicketModel.swift
//  net360
//
//  Created by Arben on 19.7.24.
//

import Foundation

struct Ticket: Identifiable {
    let id = UUID()
    let from: String?
    let to: String?
    let time: String?
    let bookingID: String?
    let price: String?
    let date: String?
    let year: String?
}
