//
//  DetailsEventCellView.swift
//  net360
//
//  Created by Arben on 19.7.24.
//

import SwiftUI

struct TicketCell: View {
    var ticket: Ticket?
    @Binding var isSelected: Bool
    @Binding var showOverlayList: Bool
    var selectedIndex: Int
    var index: Int

    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 4) {
                        DescText("Place:", color: .white.opacity(0.8))
                        SubTextBold(ticket?.from ?? "", 29, color: .white).fontWeight(.bold)
                    }
                    Spacer()
                    VStack(alignment: .center, spacing: 8) {
                        DescText("Freie Platze:", color: .white.opacity(0.8))
                        SubTextBold("Available 4", 20, color: .white)
                    }
                }
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        DescText("Time:", color: .white.opacity(0.8))
                        SubTextBold("10:00", 22, .bold, color: .white)
                        SubTextBold("12:00", 22, .bold, color: .white)
                        Spacer()
                    }
                    Spacer()
                    VStack(alignment: .center, spacing: 12) {
                        DescText("Dauer:", color: .white.opacity(0.8))
                        SubTextBold(ticket?.bookingID ?? "", 22, .bold, color: .white)
                        Spacer()
                        Button {
                            showOverlayList.toggle()
                        } label: {
                            EventTeamList(showOverlay: $showOverlayList)
                        }
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
                        .onTapGesture {
                            isSelected.toggle()
                        }
                    }
                }
                Spacer()
                SubTextBold(ticket?.date ?? "", 30, .bold, color: Color(hex: selectedIndex == 1 ? "#9D6EFF" : "#05a8cc"), textAlignment: .center)
                SubTextBold(ticket?.year ?? "", 22, .bold, color: .black)
                Spacer()
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
