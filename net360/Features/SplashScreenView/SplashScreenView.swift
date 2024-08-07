//
//  SplashScreenView.swift
//  net360
//
//  Created by Arben on 7.8.24.
//

import SwiftUI

struct SplashScreenView: View {
    @StateObject private var authManager = LoginViewModel()

    var body: some View {
        Group {
            if authManager.isLoggedIn {
                CustomTabBar(authManager: authManager)
                    .environmentObject(authManager)
            } else {
                LoginView()
                    .environmentObject(authManager)
            }
        }
        .onAppear {
            authManager.checkLoggedIn()
        }
    }
}
