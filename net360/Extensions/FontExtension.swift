//
//  FontExtension.swift
//  net360
//
//  Created by Arben on 17.7.24.
//

import SwiftUI

extension Font {
    static func ubuntuCustomFont(ofSize size: CGFloat) -> Font {
        return Font.custom("Ubuntu", size: size)
    }
    
    init(_ font: Ubuntu, size: CGFloat = 16) {
        var fontType = font
        if UIAccessibility.isBoldTextEnabled {
            fontType = .bold
        }
        guard let font = UIFont(name: fontType.rawValue, size: size) else {
            self.init(UIFont.systemFont(ofSize: size, weight: fontType.weight))
            return
        }
        
        let metrics = UIFontMetrics.default.scaledFont(for: font)
        self.init(font: metrics)
    }
    init(font: UIFont) {
        self = Font(font as CTFont)
    }
    
    enum Ubuntu: String {
        case regular = "Ubuntu"
        case bold = "UbuntuB"
        case light = "Ubuntu-L"
        
        
        var weight: UIFont.Weight {
            switch self {
            case .regular:
                return .regular
            case .bold:
                return .bold
            case .light:
                return .light
            }
        }
    }
}
