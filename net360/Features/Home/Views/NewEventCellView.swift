//
//  NewEventCellView.swift
//  net360
//
//  Created by Arben on 19.7.24.
//

import SwiftUI

struct NewEventCellView: View {
    let event: Event1
    
    var body: some View {
        NavigationLink(destination: TourPlanListView()) {
            HStack {
                HStack(spacing: 15) {
                    VStack(alignment: .center) {
                        DescText("Active", 12, color: .gray)
                        let speaker = event.speaker == "1" ? "Enevt" : "Events"
                        DescText(speaker, 12, color: .gray)
                        DescText(event.speaker, 20, color: .black.opacity(0.7)).bold()
                    }
                Divider()
                    SubTextBold(event.title, 16, color: .black.opacity(0.7))
                }
                Spacer()
                Image(systemName:  "chevron.right")
                    .customImageModifier(width: 8, renderingMode: .original, color: Color(hex: "#00A3FF"), aspectRatio: .fit)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.3), radius: 2, x: 0, y: 0)
            .padding(1)
        }
    }
}

struct Event1: Identifiable {
    let id = UUID()
    let title: String
    let speaker: String
    let hall: String
}
