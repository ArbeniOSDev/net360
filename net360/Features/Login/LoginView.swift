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
            Image("360netLogo1")
                .customImageModifier(width: 600, renderingMode: .original, aspectRatio: .fit)
//                .customImageHeightModifier(height: 350, renderingMode: .original, aspectRatio: .fill)
                .rotationEffect(.degrees(35))
                .opacity(0.3)
                .bottomPadding(-350)
                .horizontalPadding(-200)
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    content
                        .frame(width: geometry.size.width)
                        .frame(minHeight: geometry.size.height)
                }
            }
            
            if authManager.isLoading {
                loader
            }
        }
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $authManager.showAlert) {
            Alert(title: Text("Error"), message: Text(authManager.errorMessage ?? "Server Error"), dismissButton: .default(Text("OK")))
        }
    }
    
    private var backgroundGradient: some View {
        Color("mainColor").opacity(0.85)
            .overlay {
                LinearGradient(gradient: Gradient(colors: [
                    Color(hex: "#002F5C"),
                     Color(hex: "#00C5FE")
                ]), startPoint: .topTrailing, endPoint: .bottomLeading)
            }
    }
    
    private var content: some View {
        VStack(spacing: 30) {
            Spacer()
            loginForm
                .horizontalPadding(15)
            Spacer()
        }
    }
    
    private var loginForm: some View {
        VStack(spacing: 20) {
            VStack(spacing: 20) {
                Spacer()
            Image("logo")
                .customImageHeightModifier(height: 50, aspectRatio: .fit)
                .bottomPadding(30)
                inputField(icon: "person", placeholder: "E-Mail Address", text: $authManager.username)
                passwordField
                loginButton
                    .verticalPadding(15)
                Divider()
                descriprion
                    .verticalPadding(10)
//                VStack(spacing: 15) {
//                    hilfeButton
//                    contactButton
//                }
            }
            Spacer()
            HStack {
                DescText("powered by", color: .white).italic()
                Image("360netLogo")
                    .customImageModifier(width: 22, renderingMode: .original, aspectRatio: .fit)
                DescText("360net.ch", color: .white)
            }
        }.horizontalPadding(20)
    }
    
    private var passwordField: some View {
        HStack {
            Image(systemName: "lock")
                .foregroundColor(.white)
            if showPassword {
                TextField("Password", text: $authManager.password)
                    .font(.ubuntuCustomFont(ofSize: 16))
                    .foregroundColor(.white)
            } else {
                SecureField("Password", text: $authManager.password)
                    .font(.ubuntuCustomFont(ofSize: 16))
                    .foregroundColor(.white)
            }
            Button(action: { showPassword.toggle() }) {
                Image(systemName: showPassword ? "eye" : "eye.slash")
                    .foregroundColor(.white)
            }
        }
        .padding(12)
        .background(Capsule()
        .fill(Color(hex: "#D9D9D9")).opacity(0.3))
        .overlay {
            Capsule()
                .stroke(Color.white, lineWidth: 1)
        }
    }
    
    private func inputField(icon: String, placeholder: String, text: Binding<String>) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
            TextField(placeholder, text: text)
                .font(.ubuntuCustomFont(ofSize: 16))
                .foregroundColor(.white)
        }
        .padding(12)
        .background(Capsule()
            .fill(Color(hex: "#D9D9D9")).opacity(0.3))
        .overlay {
            Capsule()
                .stroke(Color.white, lineWidth: 1)
        }
    }
    
    private var loader: some View {
        VStack {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
            Spacer()
        }
    }
    
    private var loginButton: some View {
        Button(action: {
            authManager.makeLoginAPI()
        }) {
            DescText("LOGIN", 14, color: .white)
                .frame(maxWidth: .infinity)
                .padding(12)
                .background(Color.loginColor)
                .cornerRadius(40)
        }.shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 3)
    }
    
    private var hilfeButton: some View {
        Button(action: {

        }) {
            DescText("Brauchen Soe Hilfe?", 14, color: .white)
                .frame(maxWidth: .infinity)
                .padding(12)
                .background(Color(hex: "#28A745"))
                .cornerRadius(40)
        }.shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 3)
    }
    
    private var contactButton: some View {
        Button(action: {
 
        }) {
            DescText("Kontakt IT-Service?", 14, color: .black)
                .frame(maxWidth: .infinity)
                .padding(12)
                .background(Color(hex: "FFC107"))
                .cornerRadius(40)
        }.shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 3)
    }
    
    private var descriprion: some View {
        DescText("Für dich entworfen von Finance & HR-Experten!", 16, color: .white).bold()
            .frame(width: 200)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
