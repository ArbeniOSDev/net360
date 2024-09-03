//
//  DetailsEventCellView.swift
//  net360
//
//  Created by Arben on 19.7.24.
//

import SwiftUI

struct AllEventsTicketCell: View {
    var ticket: Details?
    var cityName: String?
    var eventName: String = "Zirkus Knie 2024"
    var isSelected: Bool
    @Binding var showOverlayList: Bool
    var selectedIndex: Int
    var index: Int
    var onSelect: (Int, String) -> Void
    let dateString = "AUG 04 2024"
    var eventType: EventType2?
    var coverSelect: ((Int) -> Void)?
    var cellIsClosed: Bool = false

    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                SubTextBold(eventName, 24, color: .white)
                HStack(alignment: .firstTextBaseline) {
                    VStack(alignment: .leading) {
                        DescText("Ort", 11, color: .white.opacity(0.8))
                        SubTextBold(cityName ?? "Zürich", 20, color: .white).fontWeight(.bold)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        DescText("Freie Platze", 11, color: .white.opacity(0.8))
                        SubTextBold("\(String(ticket?.availablePlaces ?? 0))", 18, color: .white)
                    }
                }
                HStack {
                    VStack(alignment: .leading) {
                        DescText("Zeit", 11, color: .white.opacity(0.8))
                        HStack(spacing: 8) {
                            SubTextBold("10:00", 16, .bold, color: .white)
                            SubTextBold("-", 16, .bold, color: .white)
                            SubTextBold("12:00", 16, .bold, color: .white)
                        }
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        DescText("Dauer", 11, color: .white.opacity(0.8))
                        SubTextBold(ticket?.eventTotalTime ?? "02:00", 16, .bold, color: .white)
                    }
                }
                HStack {
                    Button {
                        coverSelect?(ticket?.id ?? 0)
                        showOverlayList.toggle()
                    } label: {
                        SupervisiorTeamList()
                        Spacer()
                        Image(systemName: "arrow.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                        EventTeamList()
                    }
                }
            }
            .padding()
            .background(eventType == .public ? Color.customBlueColor : Color(hex: "#044675"))
            .foregroundColor(.white)
            .cornerRadius(15)
            VStack(alignment: .center, spacing: 5) {
                if selectedIndex == 0 {
                    HStack {
                        Spacer()
                        Button(action: {
                            if let id = ticket?.id {
                                onSelect(id, ticket?.date ?? dateString) // Pass date here
                                print("Selected Ticket ID: \(id)")
                            }
                        }) {
                            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                                .resizable()
                                .frame(width: 22, height: 22)
                                .foregroundColor(eventType == .public ? Color.customBlueColor : Color(hex: "#DB1971"))
                        }
                    }
                } else {
                    HStack {
                        Spacer()
                        Image("eyeIcon")
                            .customImageHeightModifier(height: 22, renderingMode: .template, color: Color(hex: "#DB1971"), aspectRatio: .fit)
                    }
                }
                Spacer()
                let components = (ticket?.date ?? dateString).split(separator: " ")
                VStack(spacing: -5) {
                    if components.count == 3 {
                        Text(String(components[0])) // Month
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(eventType == .public ? Color.customBlueColor : Color(hex: "#044675"))
                        Text(String(components[1])) // Day
                            .font(.system(size: 37, weight: .bold))
                            .foregroundColor(eventType == .public ? Color.customBlueColor : Color(hex: "#044675"))
                        Text(String(components[2])) // Year
                            .font(.system(size: 19, weight: .bold))
                            .foregroundColor(.gray)
                    } else {
                        Text(ticket?.date ?? dateString)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
                .multilineTextAlignment(.center)
                .bottomPadding()
                Spacer()
            }
            .frame(maxWidth: 60)
            .frame(height: 175)
            .padding()
            .background(Color.white)
            .cornerRadius(15)
        }.frame(height: 210)
        .horizontalPadding(27)
        .background(Color.clear)
        .cornerRadius(15)
        .shadow(radius: 3)
        .onAppear {
            print(ticket?.id ?? 0)
        }
    }
}
