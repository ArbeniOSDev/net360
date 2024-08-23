//
//  ContactList.swift
//  net360
//
//  Created by Arben on 15.8.24.
//

import SwiftUI

struct ContactList: View {
    var people = [
        Person(name: "Melanie Guenthardt", company: "JJ Consulting", position: "Leiterin Marketing, Mitglied der Direktion", imageName: "melaniePortrait", phoneNumber: "123456789"),
        Person(name: "Mergime Raçi", company: "Lyft", position: "Head Experience & Service Design, Mitglied der Direktion", imageName: "mergimePortret"),
        Person(name: "Edona Rexhepi", company: "Spark Ventures", position: "Leiterin Account Management & Advisory Support, Mitglied des Kaders", imageName: "edonaPortrait"),
        Person(name: "Diellza Aliji", company: "DigiTech", position: "Young Talents & People Operations", imageName: "diellzaPortrait"),
        Person(name: "Jenni Huber", company: "Growth Capital", position: "Account Managerin Partnership & Events", imageName: "jenniPortrait")
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                SubTextBold("Support team", 18)
                ForEach(people.indices, id: \.self) { index in
                    CustomCell(person: people[index])
                        .topPadding()
                }.horizontalPadding(20)
            }.background(Color(hex: "F5F5F5"))
        }
    }
}
