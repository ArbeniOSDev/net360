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
                        MembersListView(memberType: $memberType)
        }
    }
}

struct MembersListView: View {
    @State private var selectedMemberIDs: Set<UUID> = [] // Track selected members by ID
    @Binding var memberType: MemberType
    @State var search: String = ""
    
    let items: [Member] = [
        Member(id: UUID(), imageName: "mergimeRaci", text: "Mergime Raci"),
        Member(id: UUID(), imageName: "melanieGuenth", text: "Melanie Guenth"),
        Member(id: UUID(), imageName: "edonaRexhepi", text: "Edona Rexhepi"),
        Member(id: UUID(), imageName: "k_kasami", text: "Kasam Kasami")
    ]
    
    // Filtered items based on search text
    var filteredItems: [Member] {
        if search.isEmpty {
            return items
        } else {
            return items.filter { $0.text.lowercased().contains(search.lowercased()) }
        }
    }
    
    var body: some View {
            VStack {
                ScrollView(showsIndicators: false) {
                    SearchBar(text: $search)
                    if memberType == .supervisior {
                        VStack {
                            HStack {
                                DescText("Supervisior Team", 18)
                                Spacer()
                            }.verticalPadding(15)
                            VStack(spacing: 7) {
                                ForEach(filteredItems) { member in
                                    CellView(
                                        imageName: member.imageName,
                                        text: member.text,
                                        isSelected: selectedMemberIDs.contains(member.id),
                                        onTap: {
                                            if selectedMemberIDs.contains(member.id) {
                                                selectedMemberIDs.remove(member.id) // Deselect
                                            } else {
                                                selectedMemberIDs.insert(member.id) // Select
                                            }
                                        }
                                    )
                                }
                            }
                        }
                    } else if memberType == .member {
                        VStack {
                            HStack {
                                DescText("Member Team", 18)
                                Spacer()
                            }.verticalPadding(15)
                            VStack(spacing: 7) {
                                ForEach(filteredItems) { member in
                                    CellView(
                                        imageName: member.imageName,
                                        text: member.text,
                                        isSelected: selectedMemberIDs.contains(member.id),
                                        onTap: {
                                            if selectedMemberIDs.contains(member.id) {
                                                selectedMemberIDs.remove(member.id) // Deselect
                                            } else {
                                                selectedMemberIDs.insert(member.id) // Select
                                            }
                                        }
                                    )
                                }
                            }
                        }
                    }
                }.padding(30)
                Button {
                    // Invite button action
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
    var onTap: () -> Void
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .imageCircleModifier(height: 55, width: 55, renderingMode: .original, color: .clear, aspectRatio: .fill, colorStroke: .white, lineWidth: 2)
            DescText(text, LayoutConstants.fontSize14)
            Spacer()
            CustomCircleButton2(action: {
                onTap()
            },fillColor: isSelected ? Color.buttonColor : Color(.systemGray3), imageName: isSelected ? "check" : "plus", color: .white)
        }
        .onTapGesture {
            onTap()
        }
    }
}
