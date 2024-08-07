//
//  LoginView.swift
//  net360
//
//  Created by Arben on 7.8.24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var authManager: LoginViewModel
    @State private var username = ""
    @State private var password = ""
    @State private var showPassword = false

    var body: some View {
        ZStack {
            backgroundGradient
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    content
                        .frame(width: geometry.size.width)
                        .frame(minHeight: geometry.size.height)
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }

    private var backgroundGradient: some View {
        Color("mainColor").opacity(0.85)
            .overlay {
                LinearGradient(gradient: Gradient(colors: [
                    Color("#001f2f"),
                    Color(red: 7/255, green: 49/255, blue: 76/255, opacity: 0.85)
                ]), startPoint: .bottom, endPoint: .top)
            }
    }

    private var content: some View {
            VStack(spacing: 30) {
                Spacer()
                loginForm
                    .horizontalPadding(15)
                Spacer()
                signupPrompt
                    .bold()
            }
    }

    private var loginForm: some View {
            VStack(spacing: 20) {
                Image("logo")
                    .customImageModifier(width: 90, aspectRatio: .fit)
                    .padding(.bottom, 25)
                inputField(icon: "person", placeholder: "E-Mail Address", text: $username)
                passwordField
                loginButton
                    .verticalPadding()
                forgotPasswordButton
            }.horizontalPadding(20)
    }

    private var passwordField: some View {
        HStack {
            Image(systemName: "lock")
                .foregroundColor(.secondary)
            if showPassword {
                TextField("Password", text: $password)
                    .font(.ubuntuCustomFont(ofSize: 16))
            } else {
                SecureField("Password", text: $password)
                    .font(.ubuntuCustomFont(ofSize: 16))
            }
            Button(action: { showPassword.toggle() }) {
                Image(systemName: "eye")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Capsule().fill(Color.white))
    }

    private func inputField(icon: String, placeholder: String, text: Binding<String>) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.secondary)
            TextField(placeholder, text: text)
                .font(.ubuntuCustomFont(ofSize: 16))
        }
        .padding()
        .background(Capsule().fill(Color.white))
    }

    private var loginButton: some View {
        Button(action: {
            authManager.performLogin()
        }) {
            DescText("Login", 20, color: .white).bold()
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.loginColor)
                .cornerRadius(40)
        }
    }

    private var forgotPasswordButton: some View {
        Button(action: {}) {
            DescText("Forgot Your Password?", 16, color: .white).underline()
                .fontWeight(.heavy)
        }
    }

    private var signupPrompt: some View {
        HStack {
            DescText("Don't have an account?", 16, color: .white)
            Button(action: {}) {
                DescText("Sing Up!", 16, color: .white).underline()
            }
        }.bottomPadding(20)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
