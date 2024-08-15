//
//  LanguageCellView.swift
//  net360
//
//  Created by Arben on 15.8.24.
//

import SwiftUI

struct LanguageCellView: View {
    
    var title: LocalizedStringKey
    var isSelected: Bool
    var emoji: String?
    var image: Image?
    
    var onClick: Callback?
    
    var body: some View {
        Button {
            onClick?()
        } label: {
            HStack {
                if emoji != nil {
                    SubText(emoji ?? "", 17)
                }
                
                Text(title)
                    .foregroundColor(.primary)
                    .padding(.leading, 10)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}
