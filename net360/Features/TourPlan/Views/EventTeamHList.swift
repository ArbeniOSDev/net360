//
//  EventTeamHList.swift
//  net360
//
//  Created by Arben on 23.7.24.
//

import SwiftUI

struct EventTeamList: View {
    let users = ["mergimeRaci", "melanieGuenth", "edonaRexhepi", "additionalUser", "edonaRexhepi", "additionalUser"] // Add more users as needed
    
    var body: some View {
        HStack(spacing: -13) {
            ForEach(Array(users.prefix(3)), id: \.self) { user in
                Image(user)
                    .resizable()
                    .imageCircleModifier(height: 45, width: 45, renderingMode: .original, color: .clear, aspectRatio: .fill, colorStroke: .white, lineWidth: 2)
            }
            
            if users.count > 3 {
                ZStack {
                    Circle()
                        .fill(Color.customBlueColor)
                        .frame(width: 37, height: 37)
                        .padding(4)
                        .foregroundColor(.clear)
                        .clipShape(Circle())
                        .background(
                            Circle().stroke(.white, lineWidth: 2)
                        )
                        DescText("+\(users.count - 3)", 18, color: .white).bold()
                }.leadingPadding(-5)
            }
        }
    }
}

struct SupervisiorTeamList: View {
    let users = ["Circle-Fisnik Sadiki", "k_kasami"] // Add more users as needed
    
    var body: some View {

            HStack(spacing: -13){
                ForEach(Array(users.prefix(2)), id: \.self) { user in
                    Image(user)
                        .resizable()
                        .imageCircleModifier(height: 45, width: 45, renderingMode: .original, color: .clear, aspectRatio: .fill, colorStroke: .white, lineWidth: 2)
                }
        }
    }
}
