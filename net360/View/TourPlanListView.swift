//
//  TourPlanListView.swift
//  net360
//
//  Created by Arben on 18.7.24.
//

import SwiftUI

struct TourPlanListView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            SubTextBold("Tourplan List", 18)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<3) { _ in
                        EventListCardView(eventType: .future)
                    }
                }.padding()
            }
            Spacer()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<3) { _ in
                        EventListCardView(eventType: .expired)
                    }
                }
                .padding()
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
