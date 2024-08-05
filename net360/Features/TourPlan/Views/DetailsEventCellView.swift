//
//  DetailsEventCellView.swift
//  net360
//
//  Created by Arben on 19.7.24.
//

import SwiftUI

struct TicketCell: View {
    var ticket: Details?
    var isSelected: Bool
    @Binding var showOverlayList: Bool
    var selectedIndex: Int
    var index: Int
    var onSelect: (Int) -> Void
    let dateString = "AUG 04 2024"
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .firstTextBaseline) {
                    VStack(alignment: .leading) {
                        DescText("Place", 11, color: .white.opacity(0.8))
                        SubTextBold(ticket?.from ?? "", 24, color: .white).fontWeight(.bold)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        DescText("Freie Platze", 11, color: .white.opacity(0.8))
                        SubTextBold("Available 4", 18, color: .white)
                    }
                }
                HStack {
                    VStack(alignment: .leading) {
                        DescText("Time", 11, color: .white.opacity(0.8))
                        VStack(alignment: .leading, spacing: 1) {
                            SubTextBold("10:00", 20, .bold, color: .white)
                            SubTextBold("12:00", 20, .bold, color: .white)
                            Spacer()
                        }
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        DescText("Dauer", 11, color: .white.opacity(0.8))
                        SubTextBold(ticket?.bookingID ?? "", 20, .bold, color: .white)
                        Button {
                            showOverlayList.toggle()
                        } label: {
                            EventTeamList(showOverlay: $showOverlayList)
                                .opacity(selectedIndex == 1 ? 0.8 : 1.0)
                        }
                        .topPadding()
                    }
                }
            }
            .padding()
            .background(selectedIndex == 1 ? Color.red.opacity(0.5) : Color(hex: "#05a8cc"))
            .foregroundColor(.white)
            .cornerRadius(15)
            VStack(alignment: .center, spacing: 5) {
                if selectedIndex != 1 {
                    HStack {
                        Spacer()
                        Button(action: {
                            if let id = ticket?.id {
                                onSelect(id)
                                print(id)
                            }
                        }) {
                            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color(hex: "#05a8cc"))
                        }
                    }
                } else {
                    Circle()
                        .stroke(Color.clear, lineWidth: 0)
                        .frame(width: 20, height: 20)
                }
                Spacer()
                let components = (ticket?.date ?? dateString).split(separator: " ")
                VStack(spacing: -5) {
                    if components.count == 3 {
                        Text(String(components[0])) // Month
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(selectedIndex == 1 ? Color.red.opacity(0.5) : Color(hex: "#05a8cc"))
                        Text(String(components[1])) // Day
                            .font(.system(size: 37, weight: .bold))
                            .foregroundColor(selectedIndex == 1 ? Color.red.opacity(0.5) : Color(hex: "#05a8cc"))
                        Text(String(components[2])) // Year
                            .font(.system(size: 19, weight: .bold))
                            .foregroundColor(.black)
                    } else {
                        Text(ticket?.date ?? dateString)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
                .bottomPadding()
                Spacer()
            }
            .frame(maxWidth: 60, maxHeight: .infinity)
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
