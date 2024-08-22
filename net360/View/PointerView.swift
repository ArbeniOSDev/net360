//
//  PointerView.swift
//  net360
//
//  Created by Arben on 21.8.24.
//

import SwiftUI

struct PointerView: View {
    var body: some View {
        HStack(spacing: 8) {
            Image("pointerIcon")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.gray)
            DescText("Click an event to start timing", 14, color: .gray)
            Spacer()
        }
    }
}
