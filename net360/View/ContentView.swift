//
//  ContentView.swift
//  net360
//
//  Created by Arben on 17.7.24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var authManager: LoginViewModel
    @State private var selectedYear: String = "2024"
    @State var search: String = ""
    @StateObject var viewModel = ContentViewModel()
    let events = [
        Event1(title: "Zirkus Knie 2024", speaker: "5", hall: "Hall 1"),
        Event1(title: "OHA 2024", speaker: "1", hall: "Hall 2"),
        Event1(title: "ZOM 2024", speaker: "2", hall: "Hall 3"),
        Event1(title: "Zugermesse 2024", speaker: "7", hall: "Hall 4"),
        Event1(title: "Winti Mäss 2024", speaker: "4", hall: "Hall 5")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.bgColor
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        SubTextBold("Kampagnen Liste", 22, color: .black.opacity(0.7))
                        TextField("Search...", text: $search)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 0.5))
                        HStack(alignment: .center, spacing: 16) {
                            Group {
                                Button {
                                    selectedYear = "2024"
                                } label: {
                                    DescText("2024", 16, color: selectedYear == "2024" ? .blue : .gray)
                                }
                                Button {
                                    selectedYear = "2023"
                                } label: {
                                    DescText("2023", 16, color: selectedYear == "2023" ? .blue : .gray)
                                }
                                Button {
                                    selectedYear = "2022"
                                } label: {
                                    DescText("2022", 16, color: selectedYear == "2022" ? .blue : .gray)
                                }
                            }
                        }.topPadding()
                    }
                    .padding()
                    ForEach(events) { event in
                        NewEventCellView(event: event)
                            .verticalPadding()
                    }
                }
                .horizontalPadding()
            }
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    Image("smzh-logo2")
                        .customImageModifier(width: 110, renderingMode: .original, color: .mainColor)
                        .if(UIDevice.current.userInterfaceIdiom == .pad) {
                            $0.scaleEffect(1.3)
                        }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                    }) {
                        Image(systemName: "bell")
                            .customImageModifier(width: 17, renderingMode: .template, color: .mainColor, aspectRatio: .fit)
                    }
                }
            }).navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
