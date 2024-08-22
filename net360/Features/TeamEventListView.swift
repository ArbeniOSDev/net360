//
//  TeamEventListView.swift
//  net360
//
//  Created by Arben on 21.8.24.
//

import SwiftUI

struct TeamEventListView: View {
    @Binding var selectedCellID: Int
    @State var superVisiorTeamNames: [String] = ["Fisnik Sadiki", "Kasam Kasami"]
    @State var eventTeamNames: [String] = ["Mergime Raci", "Melanie Guenth", "Edona Rexhepi"]

    private let supervisorImages = ["Circle-Fisnik Sadiki", "k_kasami"]
    private let eventTeamImages = ["mergimeRaci", "melanieGuenth", "edonaRexhepi"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                DescText("Supervisior Team", 18)
                ForEach(superVisiorTeamNames.indices, id: \.self) { index in
                    HStack {
                        Image(supervisorImages[index])
                            .resizable()
                            .imageCircleModifier(height: 55, width: 55, renderingMode: .original, color: .clear, aspectRatio: .fill, colorStroke: .white, lineWidth: 2)
                        DescText(superVisiorTeamNames[index], 16)
                        Spacer()
                    }
                }
                Divider()
                DescText("Event Team", 18)
                ForEach(eventTeamNames.indices, id: \.self) { index in
                    HStack {
                        Image(eventTeamImages[index])
                            .resizable()
                            .imageCircleModifier(height: 55, width: 55, renderingMode: .original, color: .clear, aspectRatio: .fill, colorStroke: .white, lineWidth: 2)
                        DescText(eventTeamNames[index], 16)
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
