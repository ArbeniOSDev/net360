//
//  InternetConnectionBannerModifier.swift
//  net360
//
//  Created by Arben on 22.7.24.
//

import SwiftUI

struct InternetConnectionBannerModifier: ViewModifier {
    @Binding var isInternetConnected: Bool
    @State var isPresented: Bool = false
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
//                .popup(isPresented: .constant(!isInternetConnected)) {
//                    FloatBottomSecond()
//                } customize: {
//                    $0
//                        .type(.floater())
//                        .position(.bottom)
//                        .animation(.spring())
//                }
//            }
            if !isInternetConnected {
                HStack(spacing: LayoutConstants.padding15) {
                    Image(systemName: "wifi.slash")
                        .customImageModifier(width: 24, color: .white)
                        .if(UIDevice.current.userInterfaceIdiom == .pad) {
                            $0.scaleEffect(1.3)
                        }
                    SubTextBold("Check you Internet Connection", LayoutConstants.fontSize13, color: .white, textAlignment: .center)
                }
                .padding(LayoutConstants.padding15)
                .frame(maxWidth: .infinity)
                .background(Color.red.cornerRadius(12))
                .padding(LayoutConstants.padding15)
//                VStack {
//                    Text("")
//                }.safeAreaInset(edge: .top) {
//                    HStack (alignment: .center, spacing: 12) {
//                        Image(systemName: "wifi.slash")
//                            .customImageModifier(width: 22, color: .white)
//                        DescText(String.noInternet.localized, color: .white)
//                    }
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 0)
//                    .padding()
//                    .background(Color.cardRightColor)
//                    .navigationBarHidden(true)
//                }
            }
        }
    }
}
