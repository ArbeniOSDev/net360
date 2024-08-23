//
//  NewEventCellView.swift
//  net360
//
//  Created by Arben on 19.7.24.
//

import SwiftUI

struct NewEventCellView: View {
    var event: Event1
    @State var isCircleVisible: Bool = true
    
    var body: some View {
        NavigationLink(destination: TourPlanListView(eventName: event.title ?? "")) {
            HStack(alignment: .center) {
                HStack(alignment: .center) {
                    ZStack(alignment: .topLeading) {
                        VStack(alignment: .center) {
                            DescText("Active", 12, color: .gray)
                            let speaker = event.speaker == "1" ? "Event" : "Events"
                            DescText(speaker, 12, color: .gray)
                            DescText(event.speaker ?? "", 20, color: .black.opacity(0.7)).bold()
                        }.topPadding(12).horizontalPadding(6)
                        if event.eventIsForToday ?? false && isCircleVisible {
                            Circle()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.blue)
                                .padding(-5)
                                .transition(.opacity)
                        }
                    }
                    Divider()
                    Spacer()
                    DescText(event.title ?? "", 18, color: .black.opacity(0.7), textAlignment: .center).bold()
                    Spacer()
                }
                
                Divider().trailingPadding(6)
                HStack(spacing: 12) {
                    VStack(spacing: 8) {
                        DescText(formatDate(event.startDate ?? ""), 16, color: .black)
                        DescText(formatDate(event.endDate ?? ""), 16, color: .black)
                    }
                    Image(systemName:  "chevron.right")
                        .customImageModifier(width: 8, renderingMode: .original, color: Color(hex: "#00A3FF"), aspectRatio: .fit)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.3), radius: 2, x: 0, y: 0)
            .padding(1)
            .onAppear {
                if event.eventIsForToday ?? false {
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                        withAnimation(.easeInOut(duration: 1.0)) {
                            isCircleVisible.toggle()
                        }
                    }
                }
            }
        }
    }
    
    func formatDate(_ dateString: String?) -> String {
        guard let dateString = dateString else { return "" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMM dd"
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
}
