//
//  TourPlanListView.swift
//  net360
//
//  Created by Arben on 18.7.24.
//

import SwiftUI

struct TourPlanListView: View {
    @State private var selectedIndex = 0
    @State private var showOverlayView: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                SubTextBold("Tourplan List", 18)
                CustomSegmentedPickerView(selectedIndex: $selectedIndex)
                    .horizontalPadding()
                ScrollView(showsIndicators: false) {
                    ForEach(0..<4) { _ in
                        if selectedIndex == 0 {
                            EventListCardView(eventType: .future)
                                .verticalPadding()
                        } else {
                            EventListCardView(eventType: .expired)
                                .verticalPadding()
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showOverlayView = true
                    }) {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
            
            if showOverlayView {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showOverlayView = false
                    }
                
                OverlayView(showOverlayView: $showOverlayView)
                    .frame(width: 300, height: 300)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
        }
    }
}

struct OverlayView: View {
    @Binding var showOverlayView: Bool
    @State private var dropDownValue1: String = ""
    @State private var dropDownValue2: String = ""
    @State private var textField2: String = ""
    @State private var showDropDown1: Bool = false
    @State private var showDropDown2: Bool = false
    var dropDownValues: [String] = ["Visar Ademi", "Diellza Aliji", "Peter Funke", "Gzim Hasani", "Mergime Reci"]
    
    var body: some View {
        VStack(spacing: 10) {
            SubTextBold("Update Verantwortlich").bottomPadding()
            CustomDropDown(selectedValue: $dropDownValue1, dropDownList: dropDownValues, shouldShowDropDown: $showDropDown1)
                .padding(.horizontal)
            
            CustomDropDown(selectedValue: $dropDownValue2, dropDownList: dropDownValues, shouldShowDropDown: $showDropDown2)
                .padding(.horizontal)
            
            HStack {
                Button(action: {
                    // Handle button action
                    showOverlayView = false
                }) {
                    Text("Close")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                }
                .padding(.top)
                Button(action: {
                    // Handle button action
                    showOverlayView = false
                }) {
                    Text("Update")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top)
            }
        }
        .padding(30)
    }
}

struct TourPlanListView_Previews: PreviewProvider {
    static var previews: some View {
        TourPlanListView()
    }
}
