//
//  CustomButtons.swift
//  net360
//
//  Created by Arben on 18.7.24.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var isChecked: Bool

    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            HStack {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(isChecked ? .blue : .gray)
            }
            .padding()
        }
    }
}

struct ThreeDotsButton: View {
    var callBack: () -> Void
    var body: some View {
        Button(action: {
            callBack()
        }) {
            ZStack {
                Circle()
                    .fill(Color(red: 59/255, green: 133/255, blue: 253/255))
                    .frame(width: 25, height: 25)
                
                Image(systemName: "ellipsis")
                    .foregroundColor(.white)
                    .font(.system(size: 13))
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct CustomDropDown: View {
//    var title: String = "Label"
    var placeholder: String = "All Types"
    @Binding var selectedValue: String
    @State var value = ""
    var dropDownList: [String?]
    @Binding var shouldShowDropDown: Bool
    @State var prompt: String = ""
    var validate: DateFieldValidator = .optionalValue
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Button(action: {
                    self.shouldShowDropDown.toggle()
                }) {
                    HStack {
                        if selectedValue.isEmpty {
                            SubText(placeholder, 16, color: .gray.opacity(0.7))
                        } else {
                            SubText(selectedValue, 16)
                        }
                        Spacer()
                        Image("arrowtriangleDown")
                            .customImageModifier(width: 12, color: .gray.opacity(0.6))
                    }.modifier(FloatingContentModifier(text: value, borderColor: Color.gray))
                }
                ZStack {
                    if self.shouldShowDropDown {
                        HStack {
                            VStack(alignment: .leading) {
                                ScrollView {
                                    ForEach(dropDownList, id: \.self) { item in
                                        Button(action: {
                                            self.value = item ?? ""
                                            selectedValue = item ?? ""
                                            self.shouldShowDropDown = false
                                        }) {
                                            SubText(item ?? "", 16)
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                                .contentShape(Rectangle())
                                        }
                                        Divider()
                                            .verticalPadding(5)
                                    }
                                }
                            }.paddingHV(LayoutConstants.padding15, 10)
                        }.frame(minHeight: 85, maxHeight: 170)
                            .foregroundColor(.gray)
                            .verticalPadding(10)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 0.4)
                            )
                            .topPadding(1)
                    }
                }
                DescText(prompt, 10, color: .red.opacity(0.7))
                    .topPadding(4)
            }
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
