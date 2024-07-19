//
//  DetailsEventListViewModel.swift
//  net360
//
//  Created by Arben on 19.7.24.
//

import Foundation

class DetailsEventListViewModel: ObservableObject {
    @Published var selectedValue = ""
    @Published var dropDownList = ["Visar Ademi", "Diellza Aliji", "Peter Funke", "Gzim Hasani", "Mergime Reci"]
    @Published var shouldShowDropDown: Bool = false
}
