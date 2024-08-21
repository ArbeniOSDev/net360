//
//  TeamEventListView.swift
//  net360
//
//  Created by Arben on 21.8.24.
//

import SwiftUI

struct TeamEventListView: View {
    @Binding var selectedCellID: Int

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                DescText("Supervisior Team", 18)
                ForEach(["Circle-Fisnik Sadiki","k_kasami"], id: \.self) { user in
                    HStack {
                        Image(user)
                            .resizable()
                            .imageCircleModifier(height: 55, width: 55, renderingMode: .original, color: .clear, aspectRatio: .fill, colorStroke: .white, lineWidth: 2)
                        DescText(user, 16)
                        Spacer()
                    }
                }
                Divider()
                DescText("Event Team", 18)
                ForEach(["mergimeRaci", "melanieGuenth", "edonaRexhepi"], id: \.self) { user in
                    HStack {
                        Image(user)
                            .resizable()
                            .imageCircleModifier(height: 55, width: 55, renderingMode: .original, color: .clear, aspectRatio: .fill, colorStroke: .white, lineWidth: 2)
                        DescText(user, 16)
                        Spacer()
                    }
                }
            }.padding(30)
            Spacer()
        }
        .onAppear {
            print(selectedCellID)
        }
    }
}

#Preview {
    UpcomingView()
}
