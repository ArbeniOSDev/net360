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
    var onComplete: (() -> Void)?
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 50, style: .continuous)
                    .frame(width: 250)
                    .foregroundColor(Color(.systemGray))
                    .foregroundStyle(.ultraThickMaterial)
                    .blendMode(.plusLighter)
                HStack {
                    Image(systemName: "arrow.right.circle.fill")
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
                        Text("Slide to start")
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                    }
                    Spacer()
                }
            }
            .frame(width: 250, height: 62)
        }
    }
}
