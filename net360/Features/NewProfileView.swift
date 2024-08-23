//
//  NewProfileView.swift
//  net360
//
//  Created by Arben on 15.8.24.
//

import SwiftUI

struct NewProfileView: View {
    @EnvironmentObject private var authManager: LoginViewModel
    @State var isEdit: Bool = false
    
    var body: some View {
        ZStack {
            Color.bgColor
                .ignoresSafeArea()
                VStack(spacing: 15) {
                        VStack(spacing: 10) {
                            CircleImageProfile(image: Image("Circle-Fisnik Sadiki"))
                            SubText("Fisnik Sadiki", 28).bold()
                            SubText("ID: 524687975", 16)
                        }.topPadding(10)
                    ScrollView {
                        VStack(spacing: 15) {
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
                            HStack {
                                Button {
                                    authManager.logout()
                                } label: {
                                    Spacer()
                                    SubText("Logout", 16, color: Color(hex: "#DB1971"))
                                    Spacer()
                                }
                            }.padding(13)
                                .background(Color(hex: "#EBEEF5"))
                                .cornerRadius(12)
                        }
                    }
                    Spacer()
                }.horizontalPadding(15)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        CustomCircleButton(action: {
                            isEdit.toggle()
                        }, imageName: "pen", size: 14)
                    }
                }
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
