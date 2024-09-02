//
//  CustomCircleButton2.swift
//  net360
//
//  Created by Besim Shaqiri on 2.9.24.
//

import SwiftUI

struct CustomCircleButton2: View {
    var action: () -> Void
    var fillColor: Color = Color.white
    var imageName: String
    var size: CGFloat = 16
    var renderingMode: Image.TemplateRenderingMode = .template
    var color: Color = Color.gray
    var width: CGFloat = 30
    var height: CGFloat = 30
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(fillColor)
                    .frameWH(width, height)
                Image(imageName)
                    .resizable()
                    .customImageHeightModifier(height: size, renderingMode: renderingMode, color: color, aspectRatio: .fit)
            }
        }
    }
}
