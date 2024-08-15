//
//  SliderButton.swift
//  net360
//
//  Created by Arben on 14.8.24.
//

import SwiftUI

struct SliderButton: View {
    @State var dragAmount: CGFloat = 0
    @State var showSliderText = true
    @State var backgroundColor: Color = Color.customBlueColor
    var onComplete: (() -> Void)?
    var text: String = ""
    var isFirstSlide: Bool

    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 50, style: .continuous)
                    .frame(width: 250)
                    .foregroundColor(backgroundColor)
                HStack {
                    Image(systemName: "arrow.right.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 52))
                        .offset(x: self.dragAmount)
                        .simultaneousGesture(DragGesture()
                            .onChanged { value in
                                if value.translation.width > 0 && value.translation.width < 190 {
                                    self.dragAmount = value.translation.width
                                }
                            }
                            .onEnded { value in
                                if dragAmount >= 100 {
                                    if isFirstSlide {
                                        backgroundColor = .red  // Change the color on first slide completion
                                    }
                                    onComplete?()
                                    withAnimation(.spring()) {
                                        dragAmount = 0
                                    }
                                } else {
                                    withAnimation(.spring()) {
                                        dragAmount = 0
                                    }
                                }
                            }
                        )
                    if showSliderText && dragAmount <= 10 {
                        SubText(text, 17, color: .white).bold()
                            .padding(.leading, 14)
                    }
                    Spacer()
                }
            }
            .frame(width: 250, height: 62)
        }
    }
}
