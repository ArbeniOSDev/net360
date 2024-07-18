//
//  EventListCell.swift
//  net360
//
//  Created by Arben on 17.7.24.
//

import SwiftUI

struct EventListCell: View {
    @Binding var event: Event
    @State private var isChecked = false
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            Text(event.name ?? "")
                .frame(width: 165, alignment: .leading)
                .lineLimit(nil)
                .padding(.leading, 6)
            Text("\(event.count ?? 0)")
                .frame(width: 55, alignment: .center)
            Button(action: {
            }) {
                HStack {
                    Spacer()
                    ThreeDotsButton {
                        viewModel.selectedEventID = event.id
                        print("CheckBoxView tapped for event ID: \(event.id ?? 0)")
                    }
                    Spacer()
                }.padding(.trailing, 10)
            }
            CheckBoxView(isChecked: $isChecked)
                .onChange(of: isChecked) { newValue in
                    viewModel.selectedEventID = event.id
                    print("CheckBoxView tapped for event ID: \(event.id ?? 0)")
                }
        }
    }
}

//struct EventListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        EventListCell()
//    }
//}
