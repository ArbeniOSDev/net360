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
    var text: String = ""
    var backgroundColor: Color = .customBlueColor

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
                        SubText(text, 18, color: .white).bold()
                            .padding(.leading, 12)
                            .shimmer(.init(tint: .white.opacity(0.5), highlight: .white, blur: 5))
                    }
                    Spacer()
                }
            }
            .frame(width: 250, height: 62)
        }
    }
}

struct ShimmerEffect: ViewModifier {
    @State private var phase: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color.white.opacity(0.4), location: phase),
                                    .init(color: Color.white.opacity(0.8), location: phase + 0.1),
                                    .init(color: Color.white.opacity(0.4), location: phase + 0.2)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .rotationEffect(.degrees(30))
                        .offset(x: -geometry.size.width * 2 + phase * geometry.size.width * 3)
                }
            )
            .mask(content)
            .onAppear {
                withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    phase = 1
                }
            }
    }
}

extension View {
    func shimmering() -> some View {
        self.modifier(ShimmerEffect())
    }
}
