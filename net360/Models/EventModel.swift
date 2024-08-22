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
    let cityName: String?
    let totalEvents: Int?
    let startDate: String?
    let endDate: String?
    let location: String?
    let venue: String?
    let eventDuration: Int?
    let eventIsForToday: Bool?
    let daysToStartEvent: Int?
}

struct Event1: Identifiable {
    var id = UUID()
    var title: String?
    var speaker: String?
    var hall: String?
    var eventIsForToday: Bool?
    var date: String?
    var startDate: String?
    var endDate: String?
    
    var eventDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.date(from: date ?? "")
    }
}
