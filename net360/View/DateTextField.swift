//
//  DateTextField.swift
//  net360
//
//  Created by Besim Shaqiri on 24.7.24.
//

import SwiftUI

struct DateTextField: View {
    @Binding var text: String
    @Binding var onClick: Bool
    var placeholder: String
    var keyboardType: UIKeyboardType = .default
    var iconName: String = "calendarIcon"
    @State var prompt: String = ""
    var validate: DateFieldValidator = .optionalValue
    @Binding var isClear: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                ZStack(alignment: .leading) {
                    if validate.isMandatory {
                        HStack {
                            if text.isEmpty {
                                MandatoryText(text: placeholder)
                            }
                        }
                    } else {
                        if text.isEmpty {
                            HStack {
                                Text(placeholder)
                                    .font(.ubuntuCustomFont(ofSize: 16))
                                    .foregroundColor(.gray.opacity(0.7))
                            }
                        }
                    }
                    HStack {
                        TextField("", text: $text)
                            .disabled(true)
                            .font(.ubuntuCustomFont(ofSize: 16))
                            .keyboardType(keyboardType)
                            .onChange(of: text) { newValue in
                                validateText(newValue: newValue)
                            }
                    }
                }
                Spacer()
                HStack {
                    if !text.isEmpty && isClear == true {
                        Button(action: {
                            text = ""
                        }) {
                            Image(systemName: "xmark")
                                .customImageModifier(width: 12, color: .blue)
                        }
                    }
//                    else {
                        Button(action: {
                            onClick.toggle()
                        }) {
                            Image(iconName)
                                .customImageModifier(width: 18, color: .black.opacity(0.5))
                        }
//                    }
                }

            }.modifier(FloatingContentModifier(text: text, borderColor: borderColor))
            DescText(prompt, 10, color: .red.opacity(0.7))
                .topPadding(4)
        }
    }
    
    func validateText(newValue: String) {
        switch validate {
        case .requiredField:
            prompt = newValue.isEmpty ? "Field is empty" : ""
        case .date:
            if newValue.isEmpty {
                prompt = "Field is empty"
            } else if !newValue.isValidDate() {
                prompt = "The value is not in the correct date format (DD-MM-YYYY)"
            } else {
                prompt = ""
            }
        case .optionalValue:
            prompt = ""
        }
    }
    
    var borderColor: Color {
        if validate == .optionalValue {
            return self.text.isEmpty ? Color.gray : .orange
        } else {
            if prompt.isEmpty {
                return self.text.isEmpty ? Color.gray : .orange
            } else {
                return .red.opacity(0.9)
            }
        }
    }
}
