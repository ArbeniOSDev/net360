//
//  DeviceResolutionResolver.swift
//  net360
//
//  Created by Arben on 17.7.24.
//

import UIKit
import SwiftUI

protocol ValueResolver {
  associatedtype ValueType
  associatedtype KeyType: Hashable

  func resolve(_ map: [KeyType: ValueType]) -> ValueType?
}

// Device Resolution Resolver
class DeviceResolutionResolver<T>: ValueResolver {
  enum DeviceResolution: Int {
    case low = 375
    case standard = 393
    case high = 430
    case iPad = 743
  }

  typealias ValueType = T

  typealias KeyType = DeviceResolution

  func resolve(_ map: [DeviceResolution: T]) -> T? {
    let resolution = Int(UIScreen.main.bounds.width)
    if resolution < DeviceResolution.standard.rawValue {
      return map[.low]
    } else if(resolution < DeviceResolution.high.rawValue) {
      return map[.standard]
    } else if (resolution < DeviceResolution.iPad.rawValue) {
      return map[.high]
    }
    return map[.iPad]
  }
}
