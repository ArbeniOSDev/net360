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
                .frame(width: 25, height: 25)
            DescText("Click an event to start timing", 16, color: .black)
            Spacer()
        }.horizontalPadding(20).topPadding()
    }
}
