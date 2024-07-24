//
//  EventModel.swift
//  net360
//
//  Created by Besim Shaqiri on 24.7.24.
//

import Foundation

struct EventModel: Identifiable {
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
