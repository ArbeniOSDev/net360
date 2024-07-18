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
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(event?.location ?? "Frauenfeld")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "#07314C"))
                    Text(event?.venue ?? "Allmend")
                        .font(.title3)
                        .foregroundColor(Color(hex: "#07314C"))
                }.padding(.bottom, 10)
                HStack {
                    VStack(alignment: .leading) {
                        DescText("Start", 12, color: .black)
                        SubTextBold("02", 20, color: .black)
                        DescText("AUG", 12, color: .black)
                    }
                    VStack(alignment: .leading) {
                        DescText("End", 12, color: .black)
                        SubTextBold("04", 20, color: .black)
                        DescText("AUG", 12, color: .black)
                    }
                }
            }.frame(maxWidth: .infinity)
            Spacer()
            VStack(alignment: .trailing, spacing: 20) {
                VStack(alignment: .trailing) {
                    SubTextBold(eventType == .future ? "15 Days to Start" : "Expired", 16, .bold, color: .white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(eventType == .future ? Color(hex: "#00A3FF") : Color(hex: "#9D6EFF"))
                        .cornerRadius(5)
                    SubTextBold("2 Days", 16, .bold, color: .white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(eventType == .future ? Color(hex: "#00A3FF") : Color(hex: "#9D6EFF"))
                        .cornerRadius(5)
                }
                .padding(.bottom, 10)
                Button(action: {
                    
                }) {
                    HStack {
                        Spacer()
                        SubTextBold("Zeitpläne", 16, .bold, color: .black)
                        Spacer()
                    }
                    .padding()
                    .background(eventType == .future ? Color(hex: "#0BFFD3") : Color(hex: "#C3FE45"))
                }
                .frame(width: 140)
                .cornerRadius(10)
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.9), radius: 6, x: 0, y: 4)
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

