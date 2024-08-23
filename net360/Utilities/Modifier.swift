//
//  Modifier.swift
//  net360
//
//  Created by Arben on 17.7.24.
//

import SwiftUI

typealias Callback = () -> Void

struct ListBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollContentBackground(.hidden)
        } else {
            content
        }
    }
}

struct ListSeparatorModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .listRowSeparator(.hidden)
        } else {
            content
                .listRowInsets(EdgeInsets())
        }
    }
}
 
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
    var clearScrollBackground: some View { self.modifier(ListBackgroundModifier()) }
    var hiddenSeparator: some View { self.modifier(ListSeparatorModifier()) }
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


struct ButtonModifier: ViewModifier {
    let width: CGFloat
    let accentColor: Color
    let color: Color
    let radius: CGFloat
    
    init(width: CGFloat = .infinity, accentColor: Color = .white, color: Color = .blue, radius: CGFloat = 5) {
        self.width = width
        self.accentColor = accentColor
        self.color = color
        self.radius = radius
    }
    
    func body(content: Content) -> some View {
        content
            .paddingHV(5, 8)
            .frame(maxWidth: width)
            .accentColor(accentColor)
            .background(color)
            .cornerRadius(radius)
    }
}

struct CardStyle: ViewModifier {
    var padding: CGFloat = 22
    var color: Color = Color.white
    var radius: CGFloat = 18
    
    func body(content: Content) -> some View {
        content
            .allPadding(padding)
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(radius)
            .shadow(color: Color.black.opacity(0.10), radius: 2, x: 0, y: 0)
    }
}
