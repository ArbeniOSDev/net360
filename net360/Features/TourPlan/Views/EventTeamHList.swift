//
//  EventTeamHList.swift
//  net360
//
//  Created by Arben on 23.7.24.
//

import SwiftUI

struct EventTeamList: View {
    
    var body: some View {

            HStack(spacing: -10){
                ForEach(["mergimeRaci","melanieGuenth","edonaRexhepi"], id: \.self) { user in
                    Image(user)
                        .resizable()
                        .imageCircleModifier(height: 45, width: 45, renderingMode: .original, color: .clear, aspectRatio: .fill, colorStroke: .white, lineWidth: 2)
                }
        }
    }
}

struct SupervisiorTeamList: View {
    
    var body: some View {

            HStack(spacing: -10){
                ForEach(["Circle-Fisnik Sadiki","k_kasami"], id: \.self) { user in
                    Image(user)
                        .resizable()
                        .imageCircleModifier(height: 45, width: 45, renderingMode: .original, color: .clear, aspectRatio: .fill, colorStroke: .white, lineWidth: 2)
                }
        }
    }
}
