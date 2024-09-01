//
//  TeamEventListView.swift
//  net360
//
//  Created by Arben on 21.8.24.
//

import SwiftUI

enum MemberType {
    case supervisior
    case member
}

struct TeamEventListView: View {
    @Binding var selectedCellID: Int
    @State private var showInviteView: Bool = false
    @State var superVisiorTeamNames: [String] = ["Fisnik Sadiki", "Kasam Kasami"]
    @State var eventTeamNames: [String] = ["Mergime Raci", "Melanie Guenth", "Edona Rexhepi"]
    @State var memberType: MemberType = .member

    private let supervisorImages = ["Circle-Fisnik Sadiki", "k_kasami"]
    private let eventTeamImages = ["mergimeRaci", "melanieGuenth", "edonaRexhepi"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    DescText("Supervisior Team", 18)
                    Spacer()
                    Button {
                        memberType = .supervisior
                        showInviteView = true
                    } label: {
                        DescText("Invite", 16)
                        Image(systemName: "plus.circle.fill")
                            .customImageModifier(width: 26, renderingMode: .template, color: Color.buttonColor, aspectRatio: .fit)
                    }
                }
                ForEach(superVisiorTeamNames.indices, id: \.self) { index in
                    HStack {
                        Image(supervisorImages[index])
                            .resizable()
                            .imageCircleModifier(height: 55, width: 55, renderingMode: .original, color: .clear, aspectRatio: .fill, colorStroke: .white, lineWidth: 2)
                        DescText(superVisiorTeamNames[index], 16)
                        Spacer()
                    }
                }
                Divider()
                HStack {
                    DescText("Event Team", 18)
                    Spacer()
                    Button {
                        memberType = .member
                        showInviteView = true
                    } label: {
                        DescText("Invite", 16)
                        Image(systemName: "plus.circle.fill")
                            .customImageModifier(width: 26, renderingMode: .template, color: Color.buttonColor, aspectRatio: .fit)
                    }
                }
                ForEach(eventTeamNames.indices, id: \.self) { index in
                    HStack {
                        Image(eventTeamImages[index])
                            .resizable()
                            .imageCircleModifier(height: 55, width: 55, renderingMode: .original, color: .clear, aspectRatio: .fill, colorStroke: .white, lineWidth: 2)
                        DescText(eventTeamNames[index], 16)
                        Spacer()
                    }
                }
            }.padding(30)
            Spacer()
        }
        .sheet(isPresented: $showInviteView) {
            HorizontalScrollView(memberType: $memberType)
            .presentationDetents([.height(230)])
        }
    }
}

struct HorizontalScrollView: View {
    @State private var selectedCellIndex: Int? = nil
    @Binding var memberType: MemberType
    
    let items = [
        ("mergimeRaci", "Mergime Raci"),
        ("melanieGuenth", "Melanie Guenth"),
        ("edonaRexhepi", "Edona Rexhepi"),
        ("k_kasami", "Kasam Kasami"),
    ]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                if memberType == .supervisior {
                    VStack {
                        HStack {
                            DescText("Supervisior Team", 18)
                            Spacer()
                        }.horizontalPadding()
                        HStack(spacing: 7) {
                            ForEach(0..<items.count, id: \.self) { index in
                                CellView(imageName: items[index].0, text: items[index].1, isSelected: selectedCellIndex == index)
                                    .onTapGesture {
                                        selectedCellIndex = index
                                    }
                            }
                        }
                        .padding()
                    }
                } else if memberType == .member {
                    VStack {
                        HStack {
                            DescText("Member Team", 18)
                            Spacer()
                        }.horizontalPadding()
                        HStack(spacing: 7) {
                            ForEach(0..<items.count, id: \.self) { index in
                                CellView(imageName: items[index].0, text: items[index].1, isSelected: selectedCellIndex == index)
                                    .onTapGesture {
                                        selectedCellIndex = index
                                    }
                            }
                        }
                        .padding()
                    }
                }
            }
            Button {
                
            } label: {
                HStack {
                    Spacer()
                    SubTextBold("Invite", 16, .bold, color: .white)
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.buttonColor)
                .cornerRadius(8)
            }
            .padding(.horizontal)
        }
    }
}

struct CellView: View {
    var imageName: String
    var text: String
    var isSelected: Bool
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(imageName)
                    .resizable()
                    .imageCircleModifier(height: 55, width: 55, renderingMode: .original, color: .clear, aspectRatio: .fill, colorStroke: .white, lineWidth: 2)
                
                if isSelected {
                    Image("checkMark")
                        .resizable()
                        .imageCircleModifier(height: 20, width: 20, renderingMode: .original, color: .clear, aspectRatio: .fill, colorStroke: .white, lineWidth: 0)
                }
            }
            DescText(text)
        }
    }
}
