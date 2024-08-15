//
//  Colors.swift
//  net360
//
//  Created by Arben on 17.7.24.
//

import SwiftUI

extension Color {
    ///Primary Text - Very dark blue
    static let mainColor = Color("mainColor")
    static let loginColor = Color("loginColor")
    static let vorsorgeColor = Color("vorsorgeColor")
    static let bgColor = Color("bgColor")
    static let customBlueColor = Color("blueColor")
}
 
extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}
