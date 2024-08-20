//
//  EventListCardView.swift
//  net360
//
//  Created by Arben on 18.7.24.
//

import SwiftUI

enum EventType {
    case expired
    case future
}

enum EventType2 {
    case `public`
    case `private`
}

struct EventListCardView: View {
    var event: Event?
    var eventType: EventType
    @State private var navigateToDetails = false
    
    var body: some View {
        HStack {
            VStack(spacing: 15) {
                HStack {
                    VStack(alignment: .leading) {
                        SubTextBold(event?.location ?? "Basel", 22, .bold, color: Color(hex: "#07314C"))
                        SubTextBold(event?.venue ?? "Allmend", 16, .bold, color: .gray)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        SubTextBold(eventType == .future ? "15 Days to Start" : "Expired", 14, .bold, color: .white)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(eventType == .future ? Color(hex: "#00A3FF") : Color(hex: "#9D6EFF"))
                            .cornerRadius(5)
                        SubTextBold("2 Days", 14, .bold, color: .white)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(eventType == .future ? Color(hex: "#00A3FF") : Color(hex: "#9D6EFF"))
                            .cornerRadius(5)
                    }
                }
                Spacer()
                HStack {
                    HStack(spacing: 10) {
                        VStack(alignment: .center) {
                            DescText("Start", 12, color: .black)
                            SubTextBold("02", 20, color: .black)
                            DescText("AUG", 12, color: .black)
                        }
                        VStack(alignment: .center) {
                            DescText("End", 12, color: .black)
                            SubTextBold("04", 20, color: .black)
                            DescText("AUG", 12, color: .black)
                        }
                        VStack(alignment: .center) {
                            DescText("Total", 12, color: .black)
                            SubTextBold("15", 20, color: .black)
                            DescText("Events", 12, color: .black)
                        }.padding(.leading, 20)
                    }
                    Spacer()
                    Button(action: {
                        
                    }) {
                        HStack {
                            NavigationLink(destination: DetailsEventListView()) {
                                Spacer()
                                    SubTextBold("Zeitpläne", 16, .bold, color: .black)
                                Spacer()
                            }
                        }.verticalPadding()
                            .background(eventType == .future ? Color(hex: "#0BFFD3") : Color(hex: "#C3FE45"))
                    }
                    .frame(width: 140)
                    .cornerRadius(10)
                }
            }
        }.padding(20)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.gray.opacity(0.3), radius: 2, x: 0, y: 0)
            .padding(1)
    }
}

