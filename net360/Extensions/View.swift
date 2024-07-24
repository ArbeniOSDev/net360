//
//  View.swift
//  net360
//
//  Created by Arben on 17.7.24.
//

import SwiftUI

extension View {
    
    func customCircleStyle2(width: CGFloat, height: CGFloat, aspectWidth: CGFloat, aspectHeight: CGFloat, lineWidth: CGFloat, color: Color) -> some View {
        self
            .aspectRatio(CGSize(width: aspectWidth, height: aspectHeight), contentMode: .fit)
            .frame(width: width, height: height)
            .overlay(Circle().stroke(color, lineWidth: lineWidth))
    }
    
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
    
    @inlinable func horizontalPadding(_ padding: CGFloat = 10) -> some View {
      return self.padding([.leading, .trailing], padding)
    }

    @inlinable func verticalPadding(_ padding: CGFloat = 10) -> some View {
      return self.padding([.top, .bottom], padding)
    }
    
    @inlinable func bottomPadding(_ padding: CGFloat = 10) -> some View {
      return self.padding([.bottom], padding)
    }
    
    @inlinable func topPadding(_ padding: CGFloat = 10) -> some View {
      return self.padding([.top], padding)
    }
    
    @inlinable func trailingPadding(_ padding: CGFloat = 10) -> some View {
      return self.padding([.trailing], padding)
    }
    
    @inlinable func leadingPadding(_ padding: CGFloat = 10) -> some View {
      return self.padding([.leading], padding)
    }
    
    @inlinable func allPadding(_ padding: CGFloat = 10) -> some View {
        return self.padding([.top, .bottom, .leading, .trailing], padding)
    }
    
    func paddingHV(_ horizontal: CGFloat, _ vertical: CGFloat) -> some View {
        self.padding(.horizontal, horizontal)
            .padding(.vertical, vertical)
    }
    
    func paddingHB(_ horizontal: CGFloat, _ bottom: CGFloat) -> some View {
        self.padding(.horizontal, horizontal)
            .padding(.bottom, bottom)
    }
    
    func paddingVT(_ vertical: CGFloat, _ top: CGFloat) -> some View {
        self.padding(.vertical, vertical)
            .padding(.top, top)
    }
    
    func paddingTH(_ top: CGFloat, _ horizontal: CGFloat) -> some View {
        self.padding(.top, top)
            .padding(.horizontal, horizontal)
    }
    
    func paddingLB(_ leading: CGFloat, _ bottom: CGFloat) -> some View {
        self.padding(.leading, leading)
            .padding(.bottom, bottom)
    }
    
    func paddingTB(_ top: CGFloat, _ bottom: CGFloat) -> some View {
        self.padding(.top, top)
            .padding(.bottom, bottom)
    }
    
    func paddingTL(_ top: CGFloat, _ leading: CGFloat) -> some View {
        self.padding(.top, top)
            .padding(.leading, leading)
    }
    
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
      if conditional {
        return AnyView(content(self))
      } else {
        return AnyView(self)
      }
    }
    
    func hLeading()->some View{
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing()->some View{
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter()->some View{
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    // MARK: Safe Area
    func getSafeArea()->UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return .zero
        }
        
        return safeArea
    }
}
