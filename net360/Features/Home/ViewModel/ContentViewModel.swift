//
//  ContentViewModel.swift
//  net360
//
//  Created by Arben on 18.7.24.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var selectedEventID: Int? = nil
    @Published var eventsData = [
        Event1(title: "Zirkus Knie 2024", speaker: "5", hall: "Hall 1", eventIsForToday: true, date: "15.08.2024", startDate: "15.08.2024", endDate: "15.09.2024"),
        Event1(title: "OHA 2024", speaker: "1", hall: "Hall 2", eventIsForToday: false, date: "03.03.2024", startDate: "01.06.2024", endDate: "12.06.2024"),
        Event1(title: "ZOM 2024", speaker: "2", hall: "Hall 3", eventIsForToday: false, date: "12.04.2024", startDate: "14.07.2024", endDate: "21.07.2024"),
        Event1(title: "Zugermesse 2024", speaker: "7", hall: "Hall 4", eventIsForToday: true, date: "19.11.2024", startDate: "04.04.2024", endDate: "10.04.2024"),
        Event1(title: "Winti Mäss 2024", speaker: "4", hall: "Hall 5", eventIsForToday: false, date: "01.01.2024", startDate: "22.11.2024", endDate: "29.11.2024"),
        Event1(title: "Winti 2024", speaker: "4", hall: "Hall 3", eventIsForToday: false, date: "22.02.2024", startDate: "18.12.2024", endDate: "31.12.2024")
    ]
    
    func sortedEvents(by criterion: String) -> [Event1] {
        switch criterion {
        case "Availability":
            return eventsData.sorted {
                ($0.eventIsForToday ?? false) && !($1.eventIsForToday ?? false)
            }
        case "Alphabet":
            return eventsData.sorted {
                ($0.title ?? "").localizedCaseInsensitiveCompare($1.title ?? "") == .orderedAscending
            }
        case "Date":
             return eventsData.sorted {
                 guard let startDate1 = formatDate($0.startDate),
                       let startDate2 = formatDate($1.startDate) else {
                     return false
                 }
                 return startDate1 > startDate2
             }
         default:
             return eventsData
        }
    }
    
    private func formatDate(_ dateString: String?) -> Date? {
        guard let dateString = dateString else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        return dateFormatter.date(from: dateString)
    }
}
