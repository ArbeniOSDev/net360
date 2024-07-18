//
//  CustomButtons.swift
//  net360
//
//  Created by Arben on 18.7.24.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var isChecked: Bool

    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            HStack {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(isChecked ? .blue : .gray)
            }
            .padding()
        }
    }
}

struct ThreeDotsButton: View {
    var body: some View {
        Button(action: {
            // Add your action here
        }) {
            ZStack {
                Circle()
                    .fill(Color(red: 59/255, green: 133/255, blue: 253/255))
                    .frame(width: 25, height: 25)
                
                Image(systemName: "ellipsis")
                    .foregroundColor(.white)
                    .font(.system(size: 13))
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
