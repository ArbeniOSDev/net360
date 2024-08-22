//
//  ProfileView.swift
//  net360
//
//  Created by Arben on 14.8.24.
//

import SwiftUI

struct ProfileSettingsView: View {
    let sections: [SectionData] = [
        SectionData(title: "Content", items: [
            SettingsItem(icon: "plus.circle", title: "Favorites"),
            SettingsItem(icon: "arrow.down.circle", title: "Downloads")
        ]),
        SectionData(title: "Preferences", items: [
            SettingsItem(icon: "globe", title: "Language", detail: "English"),
            SettingsItem(icon: "bell", title: "Notifications", detail: "Enabled"),
            SettingsItem(icon: "paintpalette", title: "Theme", detail: "Light"),
            SettingsItem(icon: "play.circle", title: "Background play", isToggle: true),
            SettingsItem(icon: "wifi", title: "Download via WiFi only", isToggle: true),
            SettingsItem(icon: "arrow.triangle.2.circlepath", title: "Autoplay", isToggle: true)
        ])
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.bgColor
                    .ignoresSafeArea()
            VStack(alignment: .center, spacing: 20) {
                // Profile Header
                VStack(spacing: 8) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color.buttonColor)
                        .topPadding()
                    
                    VStack(alignment: .center) {
                        Text("Ryan Schnetzer")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("ryansc@acme.co")
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            // Edit Profile Action
                        }) {
                            Text("Edit profile")
                                .font(.body)
                                .foregroundColor(.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 20)
                                .background(Color.buttonColor)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
                .horizontalPadding()
                // Settings Sections
                ScrollView {
                    ForEach(sections, id: \.title) { section in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(section.title)
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.leading, 15)
                            
                            VStack(spacing: 0) {
                                ForEach(section.items, id: \.title) { item in
                                    HStack {
                                        Image(systemName: item.icon)
                                            .frame(width: 24)
                                            .foregroundColor(Color.buttonColor)
                                        Text(item.title)
                                            .font(.body)
                                            .fontWeight(.medium)
                                        Spacer()
                                        if item.isToggle {
                                            Toggle("", isOn: .constant(true))
                                                .labelsHidden()
                                        } else if let detail = item.detail {
                                            Text(detail)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    if item != section.items.last {
                                        Divider()
                                            .padding(.leading, 50)
                                    }
                                }
                            }
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.gray.opacity(0.3), radius: 2, x: 0, y: 0)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
        }
        }
    }
}

struct SectionData {
    let title: String
    let items: [SettingsItem]
}

struct SettingsItem: Identifiable, Equatable {
    let id = UUID()
    let icon: String
    let title: String
    var detail: String? = nil
    var isToggle: Bool = false
}

struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView()
    }
}


