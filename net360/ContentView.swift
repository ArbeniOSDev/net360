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
    
    var body: some View {
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
                    Spacer()
                }
                .padding()
                HStack {
                    Text("Campaing")
                        .frame(width: 170, alignment: .center)
                    Text("Active")
                        .frame(width: 55, alignment: .leading)
                    Text("Details")
                        .frame(maxWidth: .infinity)
                    Text("Vorbei")
                        .frame(maxWidth: .infinity)
                }
                .font(.headline)
                ForEach(0..<5, id: \.self) { index in
                    EventListCell(index: index)
                        .verticalPadding(10)
                        .background(index % 2 == 0 ? Color.gray.opacity(0.2) : Color.white)
                        .verticalPadding(-4)
                }
            }
            .horizontalPadding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
