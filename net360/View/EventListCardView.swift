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

struct EventListCardView: View {
    var event: Event?
    var eventType: EventType
    
    var body: some View {
        VStack(spacing: 14) {
            Text(eventType == .expired ? "Expired" : "DAYS TO START \(15)")
                .font(.caption)
                .fontWeight(.bold)
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(eventType == .expired ? Color.red : Color.yellow)
                .foregroundColor(.white)
                .cornerRadius(5)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Divider()
            
            Text(event?.location ?? "Bern")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text(event?.venue ?? "Allmend")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Divider()
            
            Text("Start Date: \("02-Aug-2024")")
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.blue)
                .foregroundColor(.white).bold()
                .cornerRadius(5)
            
            Text("End Date: \("04-Aug-2024")")
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.blue)
                .foregroundColor(.white).bold()
                .cornerRadius(5)
            
            Text(eventType == .expired ? "Total Day \("18")" : "Total Events \("18")")
                .font(.caption)
                .fontWeight(.bold)
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(Color.yellow)
                .foregroundColor(.black)
                .cornerRadius(5)
            
            Button(action: {
                // Action for button
            }) {
                HStack {
                    Text("Reserve")
                        .font(.title3)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .padding()
                .frame(width: 110)
                .background(eventType == .future ? Color.green : Color.red)
                .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .gray, radius: 5, x: 0, y: 0)
    }
}
