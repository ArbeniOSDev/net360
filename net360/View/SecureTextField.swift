//
//  SecureTextField.swift
//  net360
//
//  Created by Besim Shaqiri on 24.7.24.
//

import SwiftUI

struct SecureTextField: View {
  @State var placeholder: String = "Password"
  @Binding var password: String
  @State private var showPassword: Bool = false
  
  var body: some View {
    HStack {
      if showPassword {
        TextField("", text: $password)
      } else {
        SecureField(placeholder, text: $password)
      }
      if !password.isEmpty {
        Button(action: { self.showPassword.toggle()}) {
            Image(systemName: showPassword ? "eye" : "eye.slash")
                .customImageModifier(width: 22, color: .mainColor)
        }
      }
    }
  }
}

struct SecureTextField_Previews: PreviewProvider {
    static var previews: some View {
      SecureTextField(password: .constant("123456"))
    }
}
