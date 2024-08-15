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
        VStack {
            // Header
            Text("Reset Password")
                .font(.largeTitle)
                .bold()
                .padding(.top, 40)
            
            Text("Must be 8 characters or longer")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top, 8)
            
            // Old Password Field
            HStack {
                if isOldPasswordVisible {
                    TextField("Old Password", text: $oldPassword)
                } else {
                    SecureField("Old Password", text: $oldPassword)
                }
                
                Button(action: {
                    isOldPasswordVisible.toggle()
                }) {
                    Image(systemName: isOldPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.top, 20)
            
            // New Password Field
            HStack {
                if isNewPasswordVisible {
                    TextField("New Password", text: $newPassword)
                } else {
                    SecureField("New Password", text: $newPassword)
                }
                
                Button(action: {
                    isNewPasswordVisible.toggle()
                }) {
                    Image(systemName: isNewPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color(.systemGray6))
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
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.top, 10)
            
            Button(action: {
                
            }) {
                Text("Reset")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.customBlueColor)
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
