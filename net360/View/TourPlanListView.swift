//
//  TourPlanListView.swift
//  net360
//
//  Created by Arben on 18.7.24.
//

import SwiftUI

struct TourPlanListView: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            SubTextBold("Tourplan List", 18)
            CustomSegmentedPickerView(selectedIndex: $selectedIndex)
                .horizontalPadding()
            ScrollView {
                ForEach(0..<4) { _ in
                    EventListHorizontalCardView(eventType: .future)
                }
                .padding([.horizontal, .top, .bottom])
            }
            Spacer()
        }
    }
}

struct TourPlanListView_Previews: PreviewProvider {
    static var previews: some View {
        TourPlanListView()
    }
}
