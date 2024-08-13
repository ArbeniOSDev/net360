//
//  LoginObject.swift
//  net360
//
//  Created by Arben on 12.8.24.
//

import Foundation

struct LoginObject: Codable {
    var accessToken, error: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token", error
    }
}

