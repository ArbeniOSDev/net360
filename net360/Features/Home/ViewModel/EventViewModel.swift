//
//  EventViewModel.swift
//  net360
//
//  Created by Besim Shaqiri on 24.7.24.
//

import Foundation
import Combine

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
    
    private let apiService: APIServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    @Published var chooseCampaignList = ["Zirkus Knie Tournee 2022 Einsatzplan", "FC Aarau - 2022", "OFFA - 2022", "LUGA - 2022", "RHEMA - 2022"]
    @Published var responsibleList = ["Adis Mesic", "Alain Kappeler", "Albion Avdijaj", "Alena Jakupi", "Alexandra Bürgin", "Amra Asani"]
    @Published var deputyResponsibleList = ["Andrea May", "Angel Maria Flores Genao", "Besim Shagiri", "Arben Zulfiu", "Aurelia Frick"]
    @Published var gender: String = ""
    @Published var selectedValue: String = ""
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func checkFieldsValue(dateFields: [EventModel]) -> Bool {
        if chooseCampaignValue.isEmpty && responsibleValue.isEmpty && deputyResponsibleValue.isEmpty && description.isEmpty && place.isEmpty {
            return false
        }
        
        for field in dateFields {
            if field.selectedDateAsString.isEmpty {
                return false
            }
        }
        
        return true
    }
    
    func makeAPI(dateFields: [EventModel]) {
        var eventDetails: [[String: Any]] = []

        for field in dateFields {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let selectedDate = dateFormatter.string(from: field.selectedFirstDate)

            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"

            let startTime = timeFormatter.string(from: field.startTime)
            let endTime = timeFormatter.string(from: field.endTime)

            let eventDetail: [String: Any] = [
                "selectedDate": selectedDate,
                "startTime": startTime,
                "endTime": endTime,
                "numberofPersons": field.numberofPersons
            ]
            
            eventDetails.append(eventDetail)
        }

        let params: [String: Any] = [
            "wahlen": chooseCampaignValue,
            "verantwortlich": responsibleValue,
            "stv": deputyResponsibleValue,
            "beschreibung": description,
            "ort": place,
            "events": eventDetails
        ]

        isLoading = true
        apiService.request(.detailsEvent, method: .post, parameters: params, headers: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.isLoading = false
                case .failure(let error):
                    self?.isLoading = false
                    self?.error = error
                }
            }, receiveValue: { [weak self] (newsDetailsObject: String?) in
                // self?.newsDetailsObject = newsDetailsObject
            })
            .store(in: &cancellables)
    }

}
