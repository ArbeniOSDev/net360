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
}

struct TourPlanListView_Previews: PreviewProvider {
    static var previews: some View {
        TourPlanListView()
    }
}
