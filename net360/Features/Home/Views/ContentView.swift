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
    private let years = Array(2020...2024).reversed()
    @State private var selectedItem: String = ""
    private let menuItems = ["Availability", "Alphabet", "Date"]
    
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
                VStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        SubTextBold("Kampagnen Liste", (18), color: .black.opacity(0.7))
                            .topPadding()
                        SearchBar(text: $search)
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
                    HStack {
                        Spacer()
                        Menu {
                            ForEach(menuItems, id: \.self) { item in
                                Button(action: {
                                    selectedItem = item
                                }) {
                                    HStack {
                                        DescText(item, 16, color: .blue)
                                        if selectedItem == item {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.blue)
                                        }
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                Image("filter")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 20, height: 20)
                                Text(selectedItem)
                            }
                        }
                    }.horizontalPadding()
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(filteredEvents) { event in
                                NewEventCellView(event: event)
                            }
                        }
                    }
                }.horizontalPadding(20)
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        authManager.logout()
                    }) {
                        Image("logoutIcon")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    Image("smzh-logo2")
                        .customImageModifier(width: 110, renderingMode: .original, color: .mainColor)
                        .if(UIDevice.current.userInterfaceIdiom == .pad) {
                            $0.scaleEffect(1.3)
                        }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddNewKampagneView(viewModel: eventViewModel)) {
                        Image(systemName: "plus.circle.fill")
                            .customImageModifier(width: 25, renderingMode: .template, color: .blue, aspectRatio: .fit)
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
