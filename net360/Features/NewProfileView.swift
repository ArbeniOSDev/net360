//
//  NewProfileView.swift
//  net360
//
//  Created by Arben on 15.8.24.
//

import SwiftUI

struct NewProfileView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Button(action: {
                            
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .font(.title2)
                        }
                        Spacer()
                        Text("Profile")
                            .font(.title3)
                            .foregroundColor(.black)
                            .bold()
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Text("Edit Profile")
                                .foregroundColor(.black)
                                .font(.callout)
                                .padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 1)
                                )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 50)
                    
                    Spacer()
                    
                    VStack(spacing: 10) {
                        CircleImageProfile(image: Image("avatar6"))
                        Text("John Doe")
                            .font(.title2)
                            .foregroundColor(.black)
                            .bold()
                        
                        Text("ID: 524687975")
                            .foregroundColor(Color.black.opacity(0.7))
                            .font(.subheadline)
                    }
                    .topPadding(20)
                }
                .frame(height: 300)
                
                Spacer()
                    .frame(height: 20)
                
                ScrollView {
                    VStack(spacing: 12) {
                        NavigationLink(destination: NewPasswordView()) {
                            ProfileOptionView(image: "passwordIcon", text: "Password")
                        }
                        ProfileOptionView(image: "faceIDIcon", text: "Face ID", hiddeRightImage: true, isForFaceId: true)
                        NavigationLink(destination: LanguagesMenu()) {
                            ProfileOptionView(image: "languageIcon", text: "Language")
                        }
                        NavigationLink(destination: ContactList()) {
                            ProfileOptionView(image: "supportIcon", text: "Support")
                        }
                        ProfileOptionView(image: "logoutIcon 1", text: "Logout", hiddeRightImage: true)
                    }
                }.padding(.horizontal, 20)
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct Language: Identifiable {
    let id = UUID()
    let title: String
    let identifier: String
    let emoji: String
}

// Example ViewModel to hold selected language identifier
class LanguageViewModel: ObservableObject {
    @Published var languageIdentifier: String = "en"
}

// Example data source
let languages = [
    Language(title: "English", identifier: "en", emoji: "🇺🇸"),
    Language(title: "German", identifier: "de", emoji: "🇩🇪")
]

struct LanguagesMenu: View {
    
    @ObservedObject var languageViewModel = LanguageViewModel()
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 10) {
                List {
                    ForEach(languages) { lang in
                        LanguageCellView(
                            title: LocalizedStringKey(lang.title),
                            isSelected: lang.identifier == languageViewModel.languageIdentifier,
                            emoji: lang.emoji
                        ) {
                            languageViewModel.languageIdentifier = lang.identifier
                        }
                        .padding(.vertical)
                    }
                }
                .background(Color.clear) // Replacing .clearScrollBackground
            }
        }
        .navigationTitle("Languages")
        .navigationBarTitleDisplayMode(.inline)
    }
}
