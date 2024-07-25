//
//  ImageButton.swift
//  net360
//
//  Created by Besim Shaqiri on 25.7.24.
//

import SwiftUI

struct ImageButton: View {
    var systemName: String
    var padding: CGFloat
    var hexColor: String
    
    var body: some View {
        Image(systemName: systemName)
            .foregroundColor(.white)
            .padding(padding)
            .background(Color(hex: hexColor))
            .cornerRadius(8)
    }
}

struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageButton(systemName: "arrow.right", padding: 8, hexColor: "#00A3FF")
    }
}
