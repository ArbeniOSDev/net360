//
//  DetailsEventListView.swift
//  net360
//
//  Created by Arben on 19.7.24.
//

import SwiftUI

struct DetailsEventListView: View {
    @StateObject var viewModel = DetailsEventListViewModel()
    @State private var selectedIndex = 0
    @State private var showAlert: Bool = false
    @State private var showOverlay: Bool = false
    @State private var isSelected: Bool = false
    @State private var selectedCells: [Int: Bool] = [:]

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.bgColor
                .ignoresSafeArea()
        VStack(spacing: 15) {
            CustomSegmentedPickerView(selectedIndex: $selectedIndex)
                .horizontalPadding()
            ScrollView {
                ForEach(viewModel.tickets) { ticket in
                    ForEach(viewModel.tickets.indices, id: \.self) { index in
                        TicketCell(
                            ticket: viewModel.tickets[index],
                            isSelected: Binding(
                                get: { selectedCells[index] ?? false },
                                set: { selectedCells[index] = $0 }
                            ),
                            showOverlayList: $showOverlay,
                            selectedIndex: selectedIndex,
                            index: index
                        ).verticalPadding()
                    }
                }
            }
        }
    }
//        List(viewModel.tickets) { ticket in
//            TicketCell(ticket: ticket, showOverlayList: $showOverlay, selectedIndex: selectedIndex)
//                .listRowInsets(EdgeInsets())
//                .listRowSeparator(.hidden)
//                .verticalPadding()
//        }.horizontalPadding()
//            .listStyle(PlainListStyle())
        .toolbar {
            if selectedIndex != 1 {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAlert = true
                    }) {
                        SubText("Save", 16, color: .blue)
                    }
                }
            }
        }
        .overlay {
            if showOverlay {
                VStack {
                    DetailsListView(dismissList: $showOverlay)
                        .horizontalPadding(20)
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Event appointed!"),
                  message: Text("You have successfully appointed in the Basel event on 04 August 2024"),
                  dismissButton: .default(Text("OK")))
        }
    }
}

struct DetailsEventListView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsEventListView()
    }
}
