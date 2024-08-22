//
//  CustomCircleButton.swift
//  net360
//
//  Created by Besim Shaqiri on 22.8.24.
//

import SwiftUI

struct CustomCircleButton: View {
    var action: () -> Void
    var imageName: String
    var size: CGFloat = 16
    var renderingMode: Image.TemplateRenderingMode = .original
    var color: Color = Color.white
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(width: 30, height: 30)
                Image(imageName)
                    .resizable()
                    .customImageHeightModifier(height: size, renderingMode: renderingMode, color: color, aspectRatio: .fit)
            }
        }
    }
}
