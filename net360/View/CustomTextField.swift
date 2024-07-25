//
//  CustomTextField.swift
//  net360
//
//  Created by Besim Shaqiri on 24.7.24.
//

import SwiftUI
import Combine
import Foundation


enum FieldValidator {
  case requiredField
  case password
  case name
  case address
  case zip
  case optionalValue
  case confirmPassword(String)
  
  var identifier: Int {
    switch self {
    case .requiredField:
      return 0
    case .password:
      return 2
    case .name:
      return 3
    case .address:
      return 4
    case .zip:
      return 5
    case .optionalValue:
      return 7
    case .confirmPassword(_):
      return 8
    }
  }
    
    var isMandatory: Bool {
        switch self {
        case .requiredField, .name:
            return true
        default:
            return false
        }
    }
  
  static func == (lhs: FieldValidator, rhs: FieldValidator) -> Bool {
    return lhs.identifier == rhs.identifier
   }
}

struct CustomTextField: View {
  var placeholder: String
  @Binding var text: String
  var validate: FieldValidator = .optionalValue
  var isMandatory: Bool = true
  var imageName: String?
  var isSecure: Bool = false
  @State var prompt: String = ""
  var keyboardType: UIKeyboardType = .default
  var hasLabelDescription = false
  var labelText: String = ""
  var textFieldColor: Color = Color.mainColor
    
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
        if hasLabelDescription {
            DescText(labelText, 13, .light, color: .white)
                .paddingLB(6, 10)
        }
      ZStack(alignment: .leading) {
          if validate.isMandatory {
          HStack {
            if text.isEmpty {
              MandatoryText(text: placeholder)
            }
          }
        } else {
            if text.isEmpty {
                DescText(placeholder, 13, color: .gray.opacity(0.7))
            }
        }
        HStack {
          if isSecure {
            SecureTextField(password: $text)
                  .font(.ubuntuCustomFont(ofSize: 13))
              .onChange(of: text) { newValue in
                validateText(newValue: newValue)
              }
          } else {
            TextField("", text: $text)
                  .font(.ubuntuCustomFont(ofSize: 13))
                  .foregroundColor(textFieldColor)
              .keyboardType(keyboardType)
              .onChange(of: text) { newValue in
                validateText(newValue: newValue)
              }
          }
        }
      }.modifier(FloatingContentModifier(text: text, borderColor: borderColor))
        Text(prompt)
            .foregroundColor(.red.opacity(0.7))
            .font(.ubuntuCustomFont(ofSize: 10))
            .paddingTL(5, 5)
    }
  }

  func validateText(newValue: String) {
      switch validate {
      case .requiredField:
        prompt = newValue.isEmpty ? "Field is empty" : ""
      case .password:
        prompt = validatePassword(newValue: newValue)
      case .name:
        prompt = newValue.isEmpty ? "Field is empty" : ""
      case .address:
        prompt = newValue.isEmpty ? "Field is empty" : ""
      case .zip:
        prompt = newValue.isEmpty ? "Field is empty" : ""
      case .optionalValue:
        prompt = ""
      case .confirmPassword(let newPassword):
        let validPasswordText = validatePassword(newValue: newValue)
        if !validPasswordText.isEmpty {
          prompt = validPasswordText
        } else if newValue.count <= 5 {
          prompt = ""
        } else if newValue != newPassword {
          prompt = "Passwords do not match."
        } else {
          prompt = ""
        }
      }
    }
  
  func validatePassword(newValue: String) -> String {
    // The validation will start after typing four characters
    if newValue.count <= 5 {
      return ""
    }
    if !newValue.isValid(regex: "^(?=.*[!@#$%^&*()\\-_=+{}|?>.<,:;~`’])(?=.*[A-Z])(?=.*[a-z]).{8,}$") {
      return "Passwords do not match."
    }
    return ""
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


struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(placeholder: "test", text: .constant("name"))
    }
}

