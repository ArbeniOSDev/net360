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
                    SubTextBold("Zeitplane", 14, color: .white)
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

struct EventListHorizontalCardView: View {
    var eventType: EventType
    
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 12) {
                Text(eventType == .expired ? "Expired" : "DAYS TO START \(15)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(eventType == .expired ? Color.red : Color.yellow)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("Bern")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text("Allmend")
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
                
                Text(eventType == .future ? "4 Days" : "4 Days")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(5)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding()
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("From: 02-Aug-2024")
                        .font(.caption)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                    
                    Text("To: 04-Aug-2024")
                        .font(.caption)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
//                Spacer()
                Button(action: {
                    // Action for button
                }) {
                    HStack {
                        Text("Zeitpläne")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(eventType == .future ? Color.green : Color.red)
                    .cornerRadius(10)
                }.frame(maxWidth: .infinity)
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .gray, radius: 5, x: 0, y: 0)
    }
}

