//
//  SegmentedView.swift
//  net360
//
//  Created by Arben on 18.7.24.
//

import SwiftUI

struct CustomSegmentedPickerView: View {
    @Binding var selectedIndex: Int
    private var titles = ["Future", "Expired"]
    private var colors = Color.white
    @State private var frames = Array<CGRect>(repeating: .zero, count: 3)

    init(selectedIndex: Binding<Int>) {
        _selectedIndex = selectedIndex
    }

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    ForEach(self.titles.indices, id: \.self) { index in
                        Button(action: { selectedIndex = index }) {
                            DescText(self.titles[index], LayoutConstants.fontSize14, .bold, color: selectedIndex == index ? .white : .mainColor)
                                .frame(maxWidth: .infinity)
                        }.padding(EdgeInsets(top: 18, leading: 1, bottom: 18, trailing: 1))
                            .background(
                            GeometryReader { geo in
                                Color.clear.onAppear { self.setFrame(index: index, frame: geo.frame(in: .global)) }
                            }
                        )
                    }
                }
                .background(
                    Capsule().fill(Color.blue)
                        .frame(width: self.frames[self.selectedIndex].width,
                               height: self.frames[self.selectedIndex].height, alignment: .topLeading)
                        .offset(x: self.frames[self.selectedIndex].minX - self.frames[0].minX)
                    , alignment: .leading
                )
            }
            .frame(height: 51)
            .background(Color(red: 0.87, green: 0.92, blue: 0.97))
            .cornerRadius(51)
            .shadow(color: .black.opacity(0.10), radius: 2, x: 0, y: 0)
        }
    }

    func setFrame(index: Int, frame: CGRect) {
        self.frames[index] = frame
    }
}
