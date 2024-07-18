//
//  EventListCell.swift
//  net360
//
//  Created by Arben on 17.7.24.
//

import SwiftUI

struct EventListCell: View {
    @State private var isChecked = false
    let index: Int
       
    var body: some View {
        HStack(alignment: .center) {
            Text("Arosa Classic Car")
                .frame(width: 165, alignment: .leading)
                .lineLimit(nil)
                .padding(.leading, 6)
            Text("5")
                .frame(width: 55, alignment: .center)
            Button(action: {
                // Action for button
            }) {
                HStack {
                    Spacer()
                    ThreeDotsButton()
                    Spacer()
                }.padding(.trailing, 10)
            }
            CheckBoxView(isChecked: $isChecked)
        }
    }
}

//struct EventListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        EventListCell()
//    }
//}
