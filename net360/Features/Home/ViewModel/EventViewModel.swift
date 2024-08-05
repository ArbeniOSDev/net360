//
//  EventViewModel.swift
//  net360
//
//  Created by Besim Shaqiri on 24.7.24.
//

import Foundation

class EventViewModel: ObservableObject {
    @Published var events: [EventModel] = []
    @Published var campaignName: String = ""
    @Published var description: String = ""
    @Published var place: String = ""
    @Published var notes: String = ""
    @Published var dropDownList = ["Dog", "Cat", "Cow", "Pig", "Other"]
    @Published var chooseCampaignValue: String = ""
    @Published var responsibleValue: String = ""
    @Published var deputyResponsibleValue: String = ""
    @Published var chooseCampaign: Bool = false
    @Published var responsible: Bool = false
    @Published var deputyResponsible: Bool = false
    
    @Published var chooseCampaignList = ["Zirkus Knie Tournee 2022 Einsatzplan", "FC Aarau - 2022", "OFFA - 2022", "LUGA - 2022", "RHEMA - 2022"]
    @Published var responsibleList = ["Adis Mesic", "Alain Kappeler", "Albion Avdijaj", "Alena Jakupi", "Alexandra Bürgin", "Amra Asani"]
    @Published var deputyResponsibleList = ["Andrea May", "Angel Maria Flores Genao", "Besim Shagiri", "Arben Zulfiu", "Aurelia Frick"]
    
}
