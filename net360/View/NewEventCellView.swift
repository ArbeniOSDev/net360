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
                    Text(event.title)
                        .font(.headline)
                        .foregroundColor(.black.opacity(0.7))
                    HStack(spacing: 10) {
                        Image("calendar")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.leading, 10)
                        SubTextBold(event.speaker, 16, color: .black.opacity(0.7))
                        SubTextBold("Events", 16, color: .black.opacity(0.7))
                    }
                    .foregroundColor(.black)
                }
                Spacer()
                Image(systemName: "arrow.right")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(hex: "#00A3FF"))
                    .cornerRadius(8)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
            .padding(.horizontal)
        }
    }
}

struct Event1: Identifiable {
    let id = UUID()
    let title: String
    let speaker: String
    let hall: String
}
