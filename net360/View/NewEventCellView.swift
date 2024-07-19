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
                VStack(alignment: .leading, spacing: 8) {
                    Text(event.title)
                        .font(.headline)
                        .foregroundColor(Color(hex: "#00A3FF"))
                    HStack {
                        Image(systemName: "person.fill")
                        Text(event.speaker)
                            .font(.subheadline)
                        Image(systemName: "building.columns.fill")
                        Text(event.hall)
                            .font(.subheadline)
                    }
                    .foregroundColor(Color(hex: "#07314C"))
                }
                Spacer()
                Image(systemName: "arrow.right")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
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
