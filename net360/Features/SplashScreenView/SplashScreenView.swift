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
                if isFaceIDValidated {
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
//            authenticateWithFaceID()
            isFaceIDValidated = true
            hasCheckedFaceIDThisSession = true
            authManager.isInitialLoginCompleted = true
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

    func authenticateWithFaceID() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate with Face ID to continue."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        isFaceIDValidated = true
                        hasCheckedFaceIDThisSession = true
                        authManager.isInitialLoginCompleted = true
                    } else {
                        authManager.logout()
                    }
                }
            }
        } else {
            authManager.makeLoginAPI()
        }
    }
}
