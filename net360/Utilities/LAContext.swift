//
//  LAContext.swift
//  net360
//
//  Created by Arben on 15.8.24.
//

import LocalAuthentication

extension LAContext {
    func authenticateUser(completion: @escaping (Bool, Error?) -> Void) {
        var error: NSError?

        // Check if the device is capable of biometric authentication
        if self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate with Face ID."

            self.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    completion(success, authenticationError)
                }
            }
        } else {
            // If the device does not support biometric authentication
            DispatchQueue.main.async {
                completion(false, error)
            }
        }
    }
}
