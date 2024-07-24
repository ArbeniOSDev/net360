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
                VStack(alignment: .leading, spacing: 12) {
                    SubTextBold(event.title, 16, color: .black.opacity(0.7))
                    HStack(spacing: 5) {
                        Image("calendar")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .padding(.trailing, 10)
                        DescText(event.speaker, 14, color: .black.opacity(0.7))
                        DescText("Events", 14, color: .black.opacity(0.7))
                    }
                    .foregroundColor(.black)
                }
                Spacer()
                Image(systemName: "arrow.right")
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color(hex: "#00A3FF"))
                    .cornerRadius(8)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
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
