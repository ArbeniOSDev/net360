//
//  ProfileOptionView.swift
//  net360
//
//  Created by Arben on 15.8.24.
//

import SwiftUI
import LocalAuthentication

struct ProfileOptionView: View {
    var image: String = ""
    var text: String = ""
    var hiddeRightImage = false
    var isForFaceId = false
    @AppStorage("isInitialLoginCompleted") var isInitialLoginCompleted: Bool = false

    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color(hex: "#e6ecfb"))
                    .frame(width: 45, height: 45)
                
                Image(image)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color(hex: "#05A8CC"))
            }
            .padding(.leading, 8)
            
            SubText(text, 16, color: .black)
                .padding(.leading, 8)
            
            Spacer()
            
            if !hiddeRightImage {
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(hex: "#bec0d2"))
                    .padding(.trailing, 8)
            }
            
            if isForFaceId {
                Toggle(isOn: $isInitialLoginCompleted) {
                    
                }
                .tint(Color(hex: "#05A8CC"))
                .onChange(of: isInitialLoginCompleted) { newValue in
                    if newValue {
                        let context = LAContext()
                        context.authenticateUser { success, _ in
                            if !success {
                                isInitialLoginCompleted = false
                            } else {
                                isInitialLoginCompleted = true
                            }
                        }
                    }
                }
            }
        }
        .padding(10)
        .background(Color(hex: "#f2f4f9"))
        .cornerRadius(12)
    }
}
