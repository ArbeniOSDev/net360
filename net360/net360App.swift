//
//  net360App.swift
//  net360
//
//  Created by Arben on 17.7.24.
//

import SwiftUI

@main
struct net360App: App {
    @StateObject private var authManager = LoginViewModel()

    var body: some Scene {
        WindowGroup {
            CustomTabBar(authManager: authManager)
                .environmentObject(authManager)
        }
    }
}
