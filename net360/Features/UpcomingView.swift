//
//  UpcomingView.swift
//  net360
//
//  Created by Arben on 21.8.24.
//

import SwiftUI

struct UpcomingView: View {
    @State private var selectedBarIndex: Int = 0
    @State private var showOverlay: Bool = false
    @State private var selectedCellID: Int = 0
    @State private var slideStartTime: String = ""
    @State private var slideEndTime: String = ""
    @State private var isFirstSlide = true
    @State private var showSheet = false
    @State private var slideCompletedTwice = false
    @State private var sliderBackgroundColor: Color = .customBlueColor
    @State private var sliderText: String = "Slide to start"
    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()
    
    var body: some View {
        VStack {
            MyEventsView(eventType: .upcoming)
        }
    }
}

#Preview {
    UpcomingView()
}
