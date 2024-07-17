//
//  LayoutConstants.swift
//  net360
//
//  Created by Arben on 17.7.24.
//

import UIKit

class LayoutConstants {
  // Paddings
  
  private static var isiPad: Bool {
      UIDevice.current.userInterfaceIdiom == .pad
  }

  private static func calculatePadding(multiplier: CGFloat) -> CGFloat {
      return isiPad ? multiplier * 1.3 : multiplier
  }
    /// iPhone: 5, iPad: 8
          static let padding5: CGFloat = calculatePadding(multiplier: 5)
    /// iPhone: 10, iPad: 13
          static let padding10: CGFloat = calculatePadding(multiplier: 10)
    /// iPhone: 15, iPad: 19,5
          static let padding15: CGFloat = calculatePadding(multiplier: 15)
    /// iPhone: 25, iPad: 26
          static let padding20: CGFloat = calculatePadding(multiplier: 20)
    /// iPhone: 25, iPad: 32,5
          static let padding25: CGFloat = calculatePadding(multiplier: 25)
    /// iPhone: 30, iPad: 39
          static let padding30: CGFloat = calculatePadding(multiplier: 30)
    /// iPhone: 20, iPad: 23
        static var customPadding20: CGFloat { return isiPad ? 20 : 23 }
    /// iPhone: 10, iPad: 20
        static var customPadding10: CGFloat { return isiPad ? 20 : 10 }
    /// iPhone: 22, iPad: 28
        static var customPadding22: CGFloat { return isiPad ? 22 : 28 }
    /// iPhone: 25, iPad: 35
        static var customPadding25: CGFloat { return isiPad ? 25 : 35 }
  
    
//  Font sizes
  static var fontSize10: CGFloat { return fontSize(lowResSize: 10, defaultSize: 10, highResSize: 11, iPad: 13) }
  static var fontSize12: CGFloat { return fontSize(lowResSize: 12, defaultSize: 12, highResSize: 13, iPad: 16) }
  static var fontSize13: CGFloat { return fontSize(lowResSize: 13, defaultSize: 13, highResSize: 14, iPad: 17) }
  static var fontSize14: CGFloat { return fontSize(lowResSize: 14, defaultSize: 14, highResSize: 15, iPad: 18) }
  static var fontSize16: CGFloat { return fontSize(lowResSize: 16, defaultSize: 16, highResSize: 17, iPad: 21) }
  static var fontSize17: CGFloat { return fontSize(lowResSize: 17, defaultSize: 17, highResSize: 18, iPad: 22) }
  static var fontSize20: CGFloat { return fontSize(lowResSize: 20, defaultSize: 20, highResSize: 21, iPad: 28) }
  static var fontSize24: CGFloat { return fontSize(lowResSize: 24, defaultSize: 24, highResSize: 25, iPad: 30) }


  
//  CornerRadius
//  static let smallCornerRadius: CGFloat = 10
//  static let normalCornerRadius: CGFloat = 12

    
// Frame
  /// iPhone: 10, iPad: 15
//      static let xxxSmallFrame: CGFloat = calculatePadding(multiplier: 10)
  /// iPhone: 47, iPad: 57
      static var customFrame47: CGFloat { return isiPad ? 57 : 47 }
    /// iPhone: 15, iPad: 25
        static var customFrame15: CGFloat { return isiPad ? 25 : 15 }
    /// iPhone: 50, iPad: 65
        static var customFrame50: CGFloat { return isiPad ? 65 : 50 }


  private static func fontSize(lowResSize: CGFloat, defaultSize: CGFloat, highResSize: CGFloat, iPad: CGFloat) -> CGFloat {
    return DeviceResolutionResolver<CGFloat>().resolve([.low: lowResSize, .high: highResSize, .iPad: iPad]) ?? defaultSize
  }

  // button
  static let buttonHeight: CGFloat = 88
  static let bottomInset: CGFloat = 100
}
