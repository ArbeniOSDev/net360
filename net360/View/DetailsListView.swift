//
//  DetailsListView.swift
//  net360
//
//  Created by Arben on 23.7.24.
//

import SwiftUI

struct DetailsListView: View {
    let details = [
        ("mergimeRaci", "Mergime Raci"),
        ("melanieGuenth", "Melanie Guenther"),
        ("edonaRexhepi", "Edona Rexhepi")
    ]
    @Binding var dismissList: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Spacer()
                SubTextBold("Participants", color: .black)
                    .padding()
                Spacer()
                Button {
                    dismissList = false
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                        .padding(.trailing, 15)
                }
            }
            List(details.indices, id: \.self) { index in
                HStack {
                    Image(details[index].0)
                        .resizable()
                        .frame(width: 55, height: 55)
                        .padding(.leading, 8)
                    DescText(details[index].1, 18, color: .black)
                        .padding(.leading, 8)
                }
                .listRowSeparator(.hidden)
                .padding(.vertical, 4)
            }
            .listStyle(.plain)
            .frame(height: 250)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

