//
//  Images.swift
//  net360
//
//  Created by Arben on 17.7.24.
//

import Foundation
import SwiftUI

enum Aspect {
    case fit
    case fill
    case original
}

extension Image {
    func customImageModifier(width: CGFloat = 22, renderingMode: Image.TemplateRenderingMode = .template, color: Color = .white, aspectRatio: Aspect = .fit) -> some View {
        self
            .resizable()
            .renderingMode(renderingMode)
            .aspectRatio(contentMode: aspectRatio == .fit ? .fit : .fill) // Choose content mode based on aspect ratio
            .frame(width: width)
            .foregroundColor(color)
    }
    
    func customImageHeightModifier(height: CGFloat = 22, renderingMode: Image.TemplateRenderingMode = .template, color: Color = .white, aspectRatio: Aspect = .fit) -> some View {
            self
                .resizable()
                .renderingMode(renderingMode)
                .aspectRatio(contentMode: aspectRatio == .fit ? .fit : .fill) // Choose content mode based on aspect ratio
                .frame(height: height)
                .foregroundColor(color)
        }
    
    func imageModifier(height: CGFloat = 8, width: CGFloat = 8, renderingMode: Image.TemplateRenderingMode = .template, color: Color = .white, aspectRatio: Aspect = .fit) -> some View {
            self
                .resizable()
                .renderingMode(renderingMode)
                .aspectRatio(contentMode: aspectRatio == .fit ? .fit : .fill) // Choose content mode based on aspect ratio
                .frame(width: width, height: height)
                .foregroundColor(color)
        }
}
