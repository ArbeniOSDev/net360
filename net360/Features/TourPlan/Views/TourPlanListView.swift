//
//  TourPlanListView.swift
//  net360
//
//  Created by Arben on 18.7.24.
//

import SwiftUI

struct TourPlanListView: View {
    @State private var selectedIndex = 0
    @State private var showOverlayView: Bool = false
    @StateObject var tourPlanListViewModel = TourPlanListViewModel()
    var eventName: String = ""
    
    var body: some View {
        ZStack {
            Color.bgColor
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 15) {
                SubTextBold("Tourplan List", 18).topPadding()
                CustomSegmentedPickerView(selectedIndex: $selectedIndex)
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 15) {
                        ForEach(tourPlanListViewModel.event ?? [], id: \.self) { event in
                            if selectedIndex == 0 {
                                EventListCardView(event: event, eventType: .future, eventName: eventName)
                            } else {
                                EventListCardView(event: event, eventType: .expired, eventName: eventName)
                            }
                        }
                    }
                }
                Spacer()
            }.horizontalPadding(10)
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button(action: {
//                            showOverlayView = true
//                        }) {
//                            Image(systemName: "square.and.pencil")
//                        }
//                    }
//                }
            
            if showOverlayView {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showOverlayView = false
                    }
                
                TourPlanOverlayView(showOverlayView: $showOverlayView)
                    .frame(width: 300, height: 450)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
        }
    }
}

struct TourPlanListView_Previews: PreviewProvider {
    static var previews: some View {
        TourPlanListView()
    }
}
