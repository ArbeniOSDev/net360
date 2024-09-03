//
//  SplashScreenView.swift
//  net360
//
//  Created by Arben on 7.8.24.
//

import SwiftUI
import LocalAuthentication

struct SplashScreenView: View {
    @StateObject private var authManager = LoginViewModel()
    @State private var isFaceIDValidated = false
    @State private var hasCheckedFaceIDThisSession = false
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        Group {
            if authManager.isInitialLoginCompleted {
                if isFaceIDValidated || !isFaceIDConfigured() {
                    CustomTabBar(authManager: authManager)
                        .environmentObject(authManager)
                } else {
                    LoginView()
                        .environmentObject(authManager)
                }
            } else {
                LoginView()
                    .environmentObject(authManager)
            }
        }
        .onAppear {
            checkInitialLoginStatus()
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active && !hasCheckedFaceIDThisSession {
                if authManager.isInitialLoginCompleted {
                    authenticateWithFaceID()
                }
            } else if newPhase == .background {
                hasCheckedFaceIDThisSession = false
                isFaceIDValidated = false
            }
        }
        .onChange(of: authManager.isInitialLoginCompleted) { _ in
            if authManager.isInitialLoginCompleted && !hasCheckedFaceIDThisSession {
                authenticateWithFaceID()
            }
        }
    }

    func checkInitialLoginStatus() {
        if authManager.isInitialLoginCompleted {
            authenticateWithFaceID()
        } else {
            authManager.checkLoggedIn()
        }
    }

    func isFaceIDConfigured() -> Bool {
        let context = LAContext()
        var error: NSError?

        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }

    func authenticateWithFaceID() {
        let context = LAContext()

        if isFaceIDConfigured() {
            let reason = "Authenticate with Face ID to continue."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        isFaceIDValidated = true
                        hasCheckedFaceIDThisSession = true
                    } else {
                        authManager.logout()
                    }
                }
            }
        } else {
            if authManager.isInitialLoginCompleted {
                DispatchQueue.main.async {
                    isFaceIDValidated = true
                    hasCheckedFaceIDThisSession = true
                }
            } else {
                DispatchQueue.main.async {
                    authManager.checkLoggedIn()
                }
            }
        }
    }
}

