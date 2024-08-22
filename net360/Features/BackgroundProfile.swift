//
//  BackgroundProfile.swift
//  net360
//
//  Created by Arben on 15.8.24.
//

import SwiftUI

struct CircleImageProfile: View {
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var inputImage: Image?
    @State private var imageSourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var image: Image
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            (inputImage ?? image)
                .resizable()
                .customCircleStyle(width: 110, height: 110, aspectWidth: 40, aspectHeight: 40, lineWidth: 4, color: .white, lineColor: .white)
                .shadow(radius: 5)
            Button(action: {
                showingActionSheet = true
            }) {
                Image(systemName: "camera.circle.fill")
                    .resizable()
                    .customCircleStyle(width: 30, height: 30, aspectWidth: 40, aspectHeight: 40, lineWidth: 2, color: .mainColor, lineColor: .white)
            }
            .padding(2)
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Select Image"), buttons: [
                    .default(Text("Photo Library")) {
                        imageSourceType = .photoLibrary
                        showingImagePicker = true
                    },
                    .default(Text("Camera")) {
                        imageSourceType = .camera
                        showingImagePicker = true
                    },
                    .cancel()
                ])
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage, sourceType: imageSourceType)
        }
    }
}
