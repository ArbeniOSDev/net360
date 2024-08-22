//
//  SegmentedView.swift
//  net360
//
//  Created by Arben on 18.7.24.
//

import SwiftUI

struct CustomSegmentedPickerView: View {
    @Binding var selectedIndex: Int
    var titles: [String]
    private var colors = Color.white
    @State private var frames = Array<CGRect>(repeating: .zero, count: 3)

    init(selectedIndex: Binding<Int>, titles: [String] = ["Current", "Expired"]) {
        _selectedIndex = selectedIndex
        self.titles = titles
    }

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    ForEach(self.titles.indices, id: \.self) { index in
                        Button(action: { selectedIndex = index }) {
                            DescText(self.titles[index], LayoutConstants.fontSize14, .bold, color: selectedIndex == index ? .white : Color.buttonColor)
                                .frame(maxWidth: .infinity)
                        }
                        .padding(EdgeInsets(top: 12, leading: 1, bottom: 12, trailing: 1))
                        .background(
                            GeometryReader { geo in
                                Color.clear.onAppear { self.setFrame(index: index, frame: geo.frame(in: .global)) }
                            }
                        )
                    }
                }
                .background(
                    Capsule()
                        .fill(Color.buttonColor)
                        .frame(width: self.frames[self.selectedIndex].width,
                               height: self.frames[self.selectedIndex].height, alignment: .topLeading)
                        .offset(x: self.frames[self.selectedIndex].minX - self.frames[0].minX)
                    , alignment: .leading
                    
                )
            }
            .frame(height: 40)
            .background(Color(hex: "#C5EAFF"))
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.10), radius: 2, x: 0, y: 0)
        }
    }

    func setFrame(index: Int, frame: CGRect) {
        self.frames[index] = frame
    }
}

