//
//  CustomTabBar.swift
//  net360
//
//  Created by Arben on 22.7.24.
//

import SwiftUI

enum TabbedItems: Int, CaseIterable {
    case home = 0
    case activity
    case settings
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .activity:
            return "Events"
        case .settings:
            return "Profile"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "homeIcon"
        case .activity:
            return "eventIcon"
        case .settings:
            return "setting"
        }
    }
}

struct CustomTabBar: View {
    @State var selectedTab = 0
    @State private var shouldOpenURL = false
    @ObservedObject var networkManager = NetworkManager()
    private var updateManager: UpdateVersionManager!
    @State var showUpdateAlert: Bool = false
    @ObservedObject var authManager: LoginViewModel

    init(dismissLunch: Binding<Bool> = .constant(false), authManager: LoginViewModel) {
        UITabBar.appearance().isHidden = true
        updateManager = UpdateVersionManager()
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(Color(hex: "#F5F5F5"))
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        self.authManager = authManager
    }
    
    var body: some View {
//        if #available(iOS 16.0, *) {
//            NavigationStack {
                contentView()
//            }
//        } else {
//            NavigationView {
//                contentView()
//            }
//        }
    }
    
    func contentView() -> some View {
        Group {
            ZStack(alignment: .bottom) {
                AlertController(showAlert: $showUpdateAlert,
                                title: "New update available",
                                message: "Install the latest available update for the application.",
                                buttons: ["Cancel",
                                          "Update app",
                                          "Skip this update"],
                                preferredAction: 1) { actionIndex in
                    if actionIndex == 1 {
                        if let url = URL(string: updateManager.appUrl), UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    } else if actionIndex == 2 {
                        updateManager.skipThisVersion()
                    }
                }
                NavigationStack {
                    TabView(selection: $selectedTab) {
                        ContentView()
                            .tag(0)
                            .environmentObject(authManager)
                        EmptyView()
                            .tag(1)
                        EmptyView()
                            .tag(2)
                    }.modifier(InternetConnectionBannerModifier(isInternetConnected: $networkManager.isConnected))
                    if selectedTab != 4 {
                        ZStack {
                            HStack{
                                ForEach((TabbedItems.allCases), id: \.self) { item in
                                    Button {
                                        selectedTab = item.rawValue
                                    } label: {
                                        CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                                    }
                                }
                            }
                        }
                        .frame(height: 52)
                        .paddingHV(12, UIDevice.current.userInterfaceIdiom == .pad ? 5 : -5)
                        .background(Color(red: 247/255, green: 243/255, blue: 247/255))
                        .verticalPadding(UIDevice.current.userInterfaceIdiom == .pad ? 0 : -10)
                    }
                }.ignoresSafeArea(.keyboard, edges: .bottom)
            }
        }
    }
}


extension CustomTabBar {
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View {
        return HStack(spacing: 5){
            Spacer()
            VStack {
                Image(imageName)
                    .customImageModifier(width: imageName == "thirdTabIcon" ? 24 : 18, color: isActive ? .blue : .gray)
                    .if(UIDevice.current.userInterfaceIdiom == .pad) {
                        $0.scaleEffect(1.3)
                    }
                SubText(title, LayoutConstants.fontSize12, color: isActive ? .blue : .gray)
            }.topPadding()
            Spacer()
        }.cornerRadius(30)
    }
}
