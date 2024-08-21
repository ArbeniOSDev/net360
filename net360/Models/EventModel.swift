//
//  EventModel.swift
//  net360
//
//  Created by Besim Shaqiri on 24.7.24.
//

import Foundation

struct EventModel: Identifiable, Hashable {
    let id = UUID()
    var selectedDateAsString: String = ""
    var showCalendarPicker: Bool = false
    var selectedFirstDate: Date = Date()
    var startTime: Date = Date()
    var endTime: Date = Date()
    var numberofPersons: Int = 1
    var campaignName: String = ""
    var description: String = ""
    var place: String = ""
    var notes: String = ""
    var valueHaustiere: String = ""
    var dropDownList = ["Dog", "Cat", "Cow", "Pig", "Other"]
}

struct Event: Identifiable, Hashable {
    let id: Int?
    let name: String?
    let count: Int?
    let location: String?
    let venue: String?
}

struct Event1: Identifiable {
    var id = UUID()
    var title: String?
    var speaker: String?
    var hall: String?
    var eventIsForToday: Bool?
    var date: String?
    
    var eventDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.date(from: date ?? "")
    }
}
