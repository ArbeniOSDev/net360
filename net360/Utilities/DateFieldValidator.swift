//
//  DateFieldValidator.swift
//  net360
//
//  Created by Arben on 17.7.24.
//

import SwiftUI

enum DateFieldValidator {
    case requiredField
    case date
    case optionalValue
    
    var identifier: Int {
        switch self {
        case .requiredField:
            return 0
        case .date:
            return 1
        case .optionalValue:
            return 2
        }
    }
    
    var isMandatory: Bool {
        switch self {
        case .requiredField, .date:
            return true
        default:
            return false
        }
    }
    
    static func == (lhs: DateFieldValidator, rhs: DateFieldValidator) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
