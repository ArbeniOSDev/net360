//
//  DetailsEventCellView.swift
//  net360
//
//  Created by Arben on 19.7.24.
//

import SwiftUI

struct TicketCell: View {
    var ticket: Ticket?
    @State private var isSelected: Bool = false
    var selectedIndex: Int
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Place:")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                        SubTextBold(ticket?.from ?? "", 29, color: .white).fontWeight(.bold)
                    }
                    Spacer()
                    VStack(alignment: .center, spacing: 8) {
                        Text("Freie Platze:")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                        SubTextBold("Available 4", 20, color: .white)
                    }
                }
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Time:")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                        Text("10:00")
                            .font(.title2)
                            .bold()
                        Text("12:00")
                            .font(.title2)
                            .bold()
                    }
                    Spacer()
                    VStack(alignment: .center, spacing: 12) {
                        Text("Dauer:")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                        Text(ticket?.bookingID ?? "")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                }
            }
            .padding()
            .background(Color(hex: selectedIndex == 1 ? "#9D6EFF" : "#05a8cc"))
            .foregroundColor(.white)
            .cornerRadius(15)
            VStack(alignment: .center, spacing: 10) {
                if selectedIndex != 1 {
                    HStack {
                        Spacer()
                        Button(action: {
                            isSelected.toggle()
                        }) {
                            Circle()
                                .stroke(isSelected ? Color.clear : Color.gray, lineWidth: 2)
                                .background(Circle().fill(isSelected ? Color(hex: "#05a8cc") : Color.clear))
                                .frame(width: 24, height: 24)
                                .overlay(isSelected ? Image(systemName: "checkmark")
                                    .foregroundColor(.white) : nil)
                        }
                    }
                    .padding(.trailing, -5)
                    .padding(.top, -15)
                }
                Text(ticket?.date ?? "")
                    .font(.title)
                    .foregroundColor(Color(hex: selectedIndex == 1 ? "#9D6EFF" : "#05a8cc"))
                    .multilineTextAlignment(.center)
                    .bold()
                Text(ticket?.year ?? "")
                    .font(.title2)
                    .bold()
            }
            .frame(maxWidth: 80, maxHeight: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(15)
        }
        .padding(.horizontal)
        .background(Color.clear)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}
