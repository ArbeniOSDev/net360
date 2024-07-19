//
//  ContentView.swift
//  net360
//
//  Created by Arben on 17.7.24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedYear: String = "2024"
    @State var search: String = ""
    @StateObject var viewModel = ContentViewModel()
    let events = [
           Event1(title: "Opening Speech", speaker: "John Doe", hall: "Hall 1"),
           Event1(title: "Lorem Ipsum", speaker: "John Doe", hall: "Hall 2"),
           Event1(title: "Opening Speech", speaker: "John Doe", hall: "Hall 3"),
           Event1(title: "Lorem Ipsum 2", speaker: "John Doe", hall: "Hall 4"),
           Event1(title: "Lorem Ipsum 3", speaker: "John Doe", hall: "Hall 5")
       ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.bgColor
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
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
                        }
                        TextField("Search...", text: $search)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 0.5))
                        Spacer()
                    }
                    .padding()
                    ForEach(events) { event in
                        NewEventCellView(event: event)
                            .verticalPadding()
                    }
                }
                .horizontalPadding()
            }
        }
    }
}

//NavigationLink(destination: TourPlanListView()) {

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
