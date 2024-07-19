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
    
    var body: some View {
        ZStack {
            VStack {
                SubTextBold("Tourplan List", 18)
                CustomSegmentedPickerView(selectedIndex: $selectedIndex)
                    .horizontalPadding()
                ScrollView(showsIndicators: false) {
                    ForEach(0..<4) { _ in
                        if selectedIndex == 0 {
                            EventListCardView(eventType: .future)
                                .verticalPadding()
                        } else {
                            EventListCardView(eventType: .expired)
                                .verticalPadding()
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showOverlayView = true
                    }) {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
            
            if showOverlayView {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showOverlayView = false
                    }
                
                OverlayView(showOverlayView: $showOverlayView)
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
