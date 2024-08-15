//
//  SupportCellView.swift
//  net360
//
//  Created by Arben on 15.8.24.
//

import SwiftUI

struct CustomCell: View {
    var person: Person?
    
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 8) {
                SubTextBold(person?.name ?? "", 17, textAlignment: .center)
                DescText(person?.position ?? "", 14, textAlignment: .center)
                
                Spacer()
                
                HStack(spacing: 20) {
                    ContactCellView(imageName: "phone", text: "", action: {
                        if let phoneNumber = person?.phoneNumber?.removeSpaces {
                            phoneNumber.callPhone()
                        }
                    })
                    ContactCellView(imageName: "email", text: "", action: {
                        if let email = person?.email?.removeSpaces {
                            email.sendEmail()
                        }
                    })
                }.frame(maxWidth: .infinity)
            }
            .padding()
            
            Spacer()
            
            VStack(alignment: .center) {
                Image(person?.imageName ?? "")
                    .imageModifier(height: 120, width: 120, renderingMode: .original, color: .gray, aspectRatio: .fit)
                    .cornerRadius(4)
                    .shadow(color: .gray, radius: 4, x: 0, y: 4)
            }.padding(.trailing, 25)
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 2)
        .padding()
    }
}

struct ContactCellView: View {
    let imageName: String
    let text: String
    var width: CGFloat = 25
    var height: CGFloat = 25
    let action: (() -> Void)? // Make action optional by adding ?

    var body: some View {
        HStack {
            if let action = action { // Check if action is not nil
                Button(action: action) {
                    Image(imageName)
                        .imageModifier(height: height, width: width, renderingMode: .original)
                    DescText(text)
                }
            } else {
                // If action is nil, display only image and text
                Image(imageName)
                    .imageModifier(height: height, width: width, renderingMode: .original)
                DescText(text)
            }
        }
    }
}
