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
    @State private var showOverlayView: Bool = false
    @State private var showMyEventsView: Bool = false
    
    var filteredEvents: [Event1] {
        if search.isEmpty {
            return viewModel.eventsData
        } else {
            return viewModel.eventsData.filter { $0.title.localizedCaseInsensitiveContains(search) }
        }
    }
    
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
                            Button {
                                showMyEventsView = true
                            } label: {
                                SubTextBold("My Events", 16, .bold, color: .white)
                                    .padding()
                                    .background(Color(hex: "#00A3FF"))
                                    .cornerRadius(10)
                                    .frame(width: 200)
                            }.topPadding()
                            .background(
                                NavigationLink(
                                    destination: MyEventsView(),
                                    isActive: $showMyEventsView,
                                    label: { EmptyView() }
                                )
                            )
                    }
                    .padding()
                    ForEach(filteredEvents) { event in
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
                        showOverlayView.toggle()
                    }) {
                        Image(systemName: "square.and.pencil")
                            .customImageModifier(width: 17, renderingMode: .template, color: .blue, aspectRatio: .fit)
                    }
                }
            }).navigationBarTitleDisplayMode(.inline)
                .overlay(content: {
                    if showOverlayView {
                        VStack {
                            AddNewKampagneView()
                        }
                        .background(Color.white)
                        .horizontalPadding(25)
                    }
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
