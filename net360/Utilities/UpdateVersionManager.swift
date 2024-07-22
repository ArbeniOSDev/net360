//
//  UpdateVersionManager.swift
//  net360
//
//  Created by Arben on 22.7.24.
//

import Foundation
import UIKit

class UpdateVersionManager {
  
  enum VersionError: Error {
    case invalidResponse, invalidBundleInfo
  }
  
  var latestVersion: String = ""
  var appUrl: String = ""
  
  func isUpdateAvailable(completion: @escaping (Bool, Error?) -> Void) {
    // The reason why country code is hard-coded is because the user can change the Region on the phone settings, and then this feature won't work!
    guard let info = Bundle.main.infoDictionary,
          let currentVersion = info["CFBundleShortVersionString"] as? String,
          let identifier = info["CFBundleIdentifier"] as? String,
          let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)&country=ch") else {
      completion(false, VersionError.invalidBundleInfo)
      return
    }
    
    let request = URLRequest(
      url: url,
      cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData
    )
    
    let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
      do {
        if let error = error { throw error }
        guard let data = data else { throw VersionError.invalidResponse }
        let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
        guard let result = (json?["results"] as? [Any])?.first as? [String: Any], let lastVersion = result["version"] as? String else {
          throw VersionError.invalidResponse
        }
          let url = result["trackViewUrl"] as? String ?? APIConstants.appStoreURL
        self?.appUrl = url
        self?.latestVersion = lastVersion
        
        if let savedVersion = UserDefaults.standard.value(forKey: UserDefaultsKey.localizationLastUpdated) as? String {
          if savedVersion.versionCompare(lastVersion) == .orderedSame {
            completion(false, nil)
            return
          }
        }
        completion(currentVersion.versionCompare(lastVersion) == .orderedAscending, nil)
      } catch {
        completion(false, error)
      }
    }
    task.resume()
  }
  
  func skipThisVersion() {
    if !latestVersion.isEmpty {
      UserDefaults.standard.setValue(latestVersion, forKey: UserDefaultsKey.localizationLastUpdated)
    }
  }
}

enum UserDefaultsKey {
  static let localizationLastUpdated = "localizationLastUpdated"
  static let skipVersion = "skipVersion"
}
