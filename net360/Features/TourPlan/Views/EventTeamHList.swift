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
                ForEach(["mergimeRaci","melanieGuenth","edonaRexhepi"],id: \.self){user in
                    Image(user)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                        .background(
                            Circle()
                                .stroke(.white, lineWidth: 2)
                        )
                }
            }
        }
    }
}
