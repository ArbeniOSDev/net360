//
//  NewPasswordView.swift
//  net360
//
//  Created by Arben on 15.8.24.
//

import SwiftUI

struct NewPasswordView: View {
    @State private var oldPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var isOldPasswordVisible: Bool = false
    @State private var isNewPasswordVisible: Bool = false
    @State private var isConfirmPasswordVisible: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.bgColor
                    .ignoresSafeArea()
            VStack {
                // Header
                DescText("Change Password", 28).bold()
                    .padding(.top, 40)
                DescText("Must be 8 characters or longer", 16, color: .gray)
                // Old Password Field
                HStack {
                    if isOldPasswordVisible {
                        TextField("Old Password", text: $oldPassword)
                            .font(.ubuntuCustomFont(ofSize: 16))
                    } else {
                        SecureField("Old Password", text: $oldPassword)
                            .font(.ubuntuCustomFont(ofSize: 16))
                    }
                    
                    Button(action: {
                        isOldPasswordVisible.toggle()
                    }) {
                        Image(systemName: isOldPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .padding(.top, 20)
                
                // New Password Field
                HStack {
                    if isNewPasswordVisible {
                        TextField("New Password", text: $newPassword)
                            .font(.ubuntuCustomFont(ofSize: 16))
                    } else {
                        SecureField("New Password", text: $newPassword)
                            .font(.ubuntuCustomFont(ofSize: 16))
                    }
                    
                    Button(action: {
                        isNewPasswordVisible.toggle()
                    }) {
                        Image(systemName: isNewPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .padding(.top, 10)
                
                // Confirm Password Field
                HStack {
                    if isConfirmPasswordVisible {
                        TextField("Confirm New Password", text: $confirmPassword)
                    } else {
                        SecureField("Confirm New Password", text: $confirmPassword)
                    }
                    
                    Button(action: {
                        isConfirmPasswordVisible.toggle()
                    }) {
                        Image(systemName: isConfirmPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .padding(.top, 10)
                
                Button(action: {
                    
                }) {
                    DescText("Reset", 16, color: .white)
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(Color.buttonColor)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
                
                Spacer()
            }
            .padding(.horizontal, 24)
            .navigationBarHidden(true)
        }
    }
    }
}
