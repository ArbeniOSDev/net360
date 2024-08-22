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
    @State private var isCircleVisible: Bool = true
    
    var body: some View {
        HStack {
            VStack(spacing: 15) {
                ZStack(alignment: .topLeading) {
                    HStack {
                        VStack(alignment: .leading) {
                            SubTextBold(event?.cityName ?? "", 22, .bold, color: Color(hex: "#07314C"))
                            SubTextBold(event?.location ?? "", 16, .bold, color: .gray)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            SubTextBold(eventType == .future ? "\(event?.daysToStartEvent ?? 0) days to Start" : "Expired", 14, .bold, color: .white)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .background(eventType == .future ? Color(hex: "#00A3FF") : Color(hex: "#9D6EFF"))
                                .cornerRadius(5)
                            SubTextBold("\(event?.eventDuration ?? 0) days", 14, .bold, color: .white)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .background(eventType == .future ? Color(hex: "#00A3FF") : Color(hex: "#9D6EFF"))
                                .cornerRadius(5)
                        }
                    }
                    if event?.eventIsForToday ?? false && isCircleVisible {
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.blue)
                            .padding(-8)
                            .transition(.opacity)
                    }
                }
                Spacer()
                HStack {
                    HStack(spacing: 10) {
                        VStack(alignment: .center) {
                            DescText("Start", 12, color: .black)
                            SubTextBold(getDay(from: event?.startDate ?? ""), 20, color: .black)
                            DescText(getMonth(from: event?.startDate ?? ""), 12, color: .black)
                        }
                        VStack(alignment: .center) {
                            DescText("End", 12, color: .black)
                            SubTextBold(getDay(from: event?.endDate ?? ""), 20, color: .black)
                            DescText(getMonth(from: event?.endDate ?? ""), 12, color: .black)
                        }
                        VStack(alignment: .center) {
                            DescText("Total", 12, color: .black)
                            SubTextBold("\(event?.totalEvents ?? 0)", 20, color: .black)
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
            .onAppear {
                if event?.eventIsForToday ?? false {
                    Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
                        withAnimation(.easeInOut(duration: 1.5)) {
                            isCircleVisible.toggle()
                        }
                    }
                }
            }
        }.padding(20)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.gray.opacity(0.3), radius: 2, x: 0, y: 0)
            .padding(1)
    }
    
    func getDay(from date: String) -> String {
        let components = date.split(separator: "-")
        return String(components[0])
    }
    
    func getMonth(from date: String) -> String {
        let components = date.split(separator: "-")
        let monthNumber = Int(components[1]) ?? 1
        let dateFormatter = DateFormatter()
        let monthName = dateFormatter.shortMonthSymbols[monthNumber - 1].uppercased()
        return monthName
    }
}

