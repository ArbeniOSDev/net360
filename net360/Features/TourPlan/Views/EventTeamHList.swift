//
//  EventTeamHList.swift
//  net360
//
//  Created by Arben on 23.7.24.
//

import SwiftUI

struct EventTeamList: View {
    @Binding var showOverlay: Bool
    
    var body: some View {
        Button {
            showOverlay = true
        } label: {
            HStack(spacing: -10){
                ForEach(["mergimeRaci","melanieGuenth","edonaRexhepi"], id: \.self) { user in
                    Image(user)
                        .resizable()
                        .imageCircleModifier(height: 45, width: 45, renderingMode: .original, color: .clear, aspectRatio: .fill, colorStroke: .white, lineWidth: 2)
                }
            }
        }
    }
}
