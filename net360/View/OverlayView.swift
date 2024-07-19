//
//  OverlayView.swift
//  net360
//
//  Created by Arben on 19.7.24.
//

import SwiftUI

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
                    showOverlayView = false
                }) {
                    SubTextBold("Close", 16, color: .white)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                }
                .padding(.top)
                Button(action: {
                    showOverlayView = false
                }) {
                    SubTextBold("Update", 16, color: .white)
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
