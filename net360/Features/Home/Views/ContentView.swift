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
    @StateObject var eventViewModel = EventViewModel()
    @State private var selectedItem: String = "Availability"
    private let years = Array(2020...2024).reversed()
    private let menuItems = ["Availability", "Alphabet", "Date"]
    
    var filteredEvents: [Event1] {
        let events = viewModel.sortedEvents(by: selectedItem)
        if search.isEmpty {
            return events
        } else {
            return events.filter { $0.title?.localizedCaseInsensitiveContains(search) == true }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.bgColor
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        SubTextBold("Kampagnen Liste", (18), color: .black.opacity(0.7))
                            .topPadding()
                        HStack {
                            SearchBar(text: $search)
                            Menu {
                                Picker(selection: $selectedItem) {
                                    ForEach(menuItems, id: \.self) { value in
                                        DescText(value, 14, color: .blue)
                                            .tag(value)
                                    }
                                } label: {}
                            } label: {
                                HStack {
                                    DescText(selectedItem, 14, color: .blue)
                                    Image("arrows")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 14)
                                }.foregroundColor(.blue)
                            }.id(selectedItem)
                        }
                        HStack(alignment: .center, spacing: 25) {
                            Spacer()
                            HStack (spacing: 20) {
                                ForEach(years, id: \.self) { year in
                                    Button {
                                        selectedYear = "\(year)"
                                    } label: {
                                        DescText("\(year)", 16, color: selectedYear == "\(year)" ? .blue : .gray)
                                    }
                                }
                            }
                            Spacer()
                        }.topPadding()
                        Divider()
                    }
                    
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(filteredEvents) { event in
                                NewEventCellView(event: event)
                            }
                        }
                    }
                }.horizontalPadding(20)
            }.toolbar(content: {
                ToolbarItem(placement: .principal) {
                    Image("smzh-logo2")
                        .customImageModifier(width: 110, renderingMode: .original, color: .mainColor)
                        .if(UIDevice.current.userInterfaceIdiom == .pad) {
                            $0.scaleEffect(1.3)
                        }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: {
                            authManager.logout()
                        }) {
                            Image("logoutIcon")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        NavigationLink(destination: AddNewKampagneView(viewModel: eventViewModel)) {
                            Image(systemName: "plus.circle.fill")
                                .customImageModifier(width: 22, renderingMode: .template, color: .blue, aspectRatio: .fit)
                        }
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
