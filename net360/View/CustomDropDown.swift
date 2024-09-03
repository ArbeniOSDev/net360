//
//  CustomDropDown.swift
//  net360
//
//  Created by Besim Shaqiri on 24.7.24.
//

import SwiftUI

struct CustomDropDownLineView: View {
    var placeholder: String = "All Types"
    @Binding var selectedValue: String
    @State var value = ""
    var dropDownList: [String?]
    @Binding var shouldShowDropDown: Bool
    @State var prompt: String = ""
    var validate: DateFieldValidator = .optionalValue
    @State private var searchText: String = ""
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Button(action: {
                    self.shouldShowDropDown.toggle()
                }) {
                    HStack {
                        if selectedValue.isEmpty {
                            SubText(placeholder, 13, color: .gray.opacity(0.7))
                        } else {
                            SubText(selectedValue, 13)
                        }
                        Spacer()
                        Image("arrowtriangleDown")
                            .customImageModifier(width: 12, color: .gray.opacity(0.6))
                    }.modifier(FloatingContentModifier(text: value, borderColor: Color.gray))
                }
                
                if self.shouldShowDropDown {
                    VStack {
                        // Search bar
                        SearchBar(text: $searchText)
                            .padding()
                        
                        // Filtered list
                        ScrollView {
                            ForEach(filteredDropDownList, id: \.self) { item in
                                Button(action: {
                                    self.value = item ?? ""
                                    selectedValue = item ?? ""
                                    self.shouldShowDropDown = false
                                    self.searchText = ""
                                }) {
                                    SubText(item ?? "", 14)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        .contentShape(Rectangle())
                                }
                                Divider()
                            }
                        }.padding(.horizontal)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 0.4)
                    )
                    .padding(.top, 1)
                }
                
                DescText(prompt, 10, color: .red.opacity(0.7))
                    .padding(.top, 4)
            }
        }
    }
    
    // Filtered dropdown list based on the search text
    private var filteredDropDownList: [String?] {
        if searchText.isEmpty {
            return dropDownList
        } else {
            return dropDownList.filter { $0?.localizedCaseInsensitiveContains(searchText) == true }
        }
    }
    
    func validateText(newValue: String) {
        switch validate {
        case .requiredField:
            prompt = newValue.isEmpty ? "Field is empty" : ""
        case .date:
            if newValue.isEmpty {
                prompt = "Field is empty"
            }
        case .optionalValue:
            prompt = ""
        }
    }
    
    var borderColor: Color {
        if validate == .optionalValue {
            return self.value.isEmpty ? Color.gray : .orange
        } else {
            if prompt.isEmpty {
                return self.value.isEmpty ? Color.gray : .orange
            } else {
                return .red.opacity(0.9)
            }
        }
    }
}

