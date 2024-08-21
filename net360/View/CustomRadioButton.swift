//
//  CustomRadioButton.swift
//  net360
//
//  Created by Arben on 21.8.24.
//

import SwiftUI

struct CustomRadioButton: View {
    let id: Int
    let label: String
    let callback: () -> Void
    @Binding var selectedRadio: String
    
    var body: some View {
        Button(action: {
            selectedRadio = String(id)
            callback()
        }) {
            HStack {
                Image(systemName: selectedRadio == String(id) ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(selectedRadio == String(id) ? .blue : .gray)
                DescText(label)
            }
        }
    }
}
