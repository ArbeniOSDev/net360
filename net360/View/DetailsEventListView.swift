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
    
    var body: some View {
        VStack {
            CustomSegmentedPickerView(selectedIndex: $selectedIndex)
        }.horizontalPadding()
        List(viewModel.tickets) { ticket in
            TicketCell(ticket: ticket)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .verticalPadding()
        }
        .listStyle(PlainListStyle())
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showAlert = true
                }) {
                    SubTextBold("Save", 20, color: .blue)
                        .padding()
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
