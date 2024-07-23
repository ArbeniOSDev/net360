//
//  AddNewKampagneView.swift
//  net360
//
//  Created by Arben on 23.7.24.
//

import SwiftUI

struct AddNewKampagneView: View {
    @State var campaignName: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            SubTextBold("Neue Kampagne", color: .black)
                .topPadding(20)
            TextField("Kampagnenname", text: $campaignName)
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.purple.opacity(0.5), lineWidth: 1)
                )
                .padding(.horizontal, 40)
            Button {
                
            } label: {
                Text("Speichern")
                    .font(.body)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.horizontal, 40)
            }
        }.frame(height: 350)
    }
}

struct AddNewKampagneView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewKampagneView()
    }
}
