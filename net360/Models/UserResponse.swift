//
//  UserResponse.swift
//  net360
//
//  Created by Arben on 7.8.24.
//

import Foundation

struct UserResponse: Codable {
    let message: String?
    let token: String?
    let userObject: UserObject?

    struct UserObject: Codable {
        let firstName: String?
        let lastName: String?
        let userId: Int?
        
        var fullName: String {
            return (firstName ?? "") + " " + (lastName ?? "")
        }
    }
}
