//
//  Modifier.swift
//  net360
//
//  Created by Arben on 17.7.24.
//

import SwiftUI
 
struct CustomFrameModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.main.bounds.size.width / 6 * 5.5,
                   height: UIScreen.main.bounds.size.width / 6 * 3.1)
//            .background(Color(hex: "#F5F5F5").opacity(0.9))
            .background(Color(hex: "#F5F5F5").opacity(0.9))
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .padding()
            .offset(y: -70)
//            .offset(y: -90)
            .padding(.bottom, -200)
    }
}
 
extension View {
    func customFrameStyle() -> some View {
        self.modifier(CustomFrameModifier())
    }
}
 
 
struct CustomCircleModifier: ViewModifier {
    let width: CGFloat
    let height: CGFloat
    let aspectWidth: CGFloat
    let aspectHeight: CGFloat
    let lineWidth: CGFloat
    let color: Color
    let lineColor: Color
 
    func body(content: Content) -> some View {
        content
            .frame(width: width, height: height)
            .aspectRatio(CGSize(width: aspectWidth, height: aspectHeight), contentMode: .fill)
            .clipShape(Circle())
            .foregroundColor(color)
            .overlay(Circle().stroke(lineColor, lineWidth: lineWidth))
    }
}
 
extension View {
    func customCircleStyle(width: CGFloat, height: CGFloat, aspectWidth: CGFloat, aspectHeight: CGFloat, lineWidth: CGFloat, color: Color, lineColor: Color) -> some View {
        self.modifier(CustomCircleModifier(width: width, height: height, aspectWidth: aspectWidth, aspectHeight: aspectHeight, lineWidth: lineWidth, color: color, lineColor: lineColor))
    }
}
 
struct FloatingContentModifier: ViewModifier {
    var text: String
    var borderColor: Color
    
    func body(content: Content) -> some View {
        content
            .animation(.easeOut, value: self.text.isEmpty)
            .paddingHV(LayoutConstants.padding15, 10)
            .frame(height: 44)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor, lineWidth: 1)
                    .background(Color.white)
                    .cornerRadius(10)
            )
    }
}
