//
//  UpcomingView.swift
//  net360
//
//  Created by Arben on 21.8.24.
//

import SwiftUI

struct UpcomingView: View {
    
    var body: some View {
        VStack {
            MainEventsView(eventType: .upcoming)
        }
    }
}

struct MyUpcomingView: View {
    
    var body: some View {
        VStack {
            MainEventsView(eventType: .myEvents)
        }
    }
}
