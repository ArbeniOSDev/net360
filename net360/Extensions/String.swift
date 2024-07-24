//
//  String.swift
//  net360
//
//  Created by Arben on 22.7.24.
//

import Foundation

extension String {
    func versionCompare(_ otherVersion: String) -> ComparisonResult {
        let versionDelimiter = "."
        var versionComponents = self.components(separatedBy: versionDelimiter)
        var otherVersionComponents = otherVersion.components(separatedBy: versionDelimiter)
        let zeroDiff = versionComponents.count - otherVersionComponents.count
        
        if zeroDiff == 0 {
            // Same format, compare normally
            return self.compare(otherVersion, options: .numeric)
        } else {
            let zeros = Array(repeating: "0", count: abs(zeroDiff))
            if zeroDiff > 0 {
                otherVersionComponents.append(contentsOf: zeros)
            } else {
                versionComponents.append(contentsOf: zeros)
            }
            return versionComponents.joined(separator: versionDelimiter)
                .compare(otherVersionComponents.joined(separator: versionDelimiter), options: .numeric)
        }
    }
    
    public func isValid(regex: String) -> Bool {
      let isMatching = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
      return isMatching
    }
    
    public func isValidDate() -> Bool {
        // Regex patterns for various date formats
        let dateRegexes = [
            #"^\d{4}-\d{2}-\d{2}$"#,  // Format: YYYY-MM-DD
            #"^\d{4}/\d{2}/\d{2}$"#,  // Format: YYYY/MM/DD
            #"^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/\d{4}$"#,  // Format: DD/MM/YYYY
            #"^(0[1-9]|[12][0-9]|3[01]).(0[1-9]|1[012]).\d{4}$"#,  // Format: DD/MM/YYYY
            #"^(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}$"#,  // Format: DD-MM/-YYYY
            #"^(0[1-9]|1[0-2])/(0[1-9]|[12][0-9]|3[01])/\d{2}$"#,  // Format: MM/DD/YY
            #"^(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])-\d{2}$"#,  // Format: MM-DD-YY
            #"^(0?[1-9]|[12][0-9]|3[01]) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4}$"#, // Format: D MMM YYYY
            #"^(0[1-9]|[12][0-9]|3[01]) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4}$"#  // Format: DD MMM YYYY
        ]
        for regex in dateRegexes {
            if isValid(regex: regex) {
                return true
            }
        }
        return false
    }
}
