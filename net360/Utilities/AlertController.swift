//
//  AlertController.swift
//  net360
//
//  Created by Arben on 22.7.24.
//

import SwiftUI

struct AlertController: UIViewControllerRepresentable {

  @Binding var showAlert: Bool
  var title: String
  var message: String
  var buttons: [String] = []
  var preferredAction: Int? = nil
  var action: ((_ index: Int) -> Void)?

  func makeUIViewController(context: UIViewControllerRepresentableContext<AlertController>) -> UIViewController {
    return UIViewController()
  }
  
  func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<AlertController>) {
    guard context.coordinator.alert == nil else { return }
    if self.showAlert {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      context.coordinator.alert = alert
      if buttons.isEmpty {
          let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
              action?(0)
          }
          alert.addAction(cancelAction)
      } else {
        buttons.enumerated().forEach { index, buttonTitle in
          let alertAction = UIAlertAction(title: buttonTitle, style: index == 0 ? .cancel : .default) { _ in
            showAlert = false
            action?(index)
          }
          alert.addAction(alertAction)
          if let preferredAction = preferredAction, preferredAction == index {
            alert.preferredAction = alertAction
          }
        }
      }
      DispatchQueue.main.async { // must be async !!
        UIApplication.topMostViewController?.present(alert, animated: true, completion: {
          self.showAlert = false
          context.coordinator.alert = nil
        })
      }
    }
  }
  
  func makeCoordinator() -> AlertController.Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: NSObject, UITextFieldDelegate {
    var alert: UIAlertController?
    var control: AlertController
    init(_ control: AlertController) {
      self.control = control
    }
  }
}

extension UIApplication {
  /// The top most view controller
  static var topMostViewController: UIViewController? {
    return UIApplication.shared.keyWindow?.rootViewController?.customVisibleViewController
  }
}

extension UIViewController {
  var customVisibleViewController: UIViewController? {
    if let navigationController = self as? UINavigationController {
      return navigationController.topViewController?.customVisibleViewController
    } else if let tabBarController = self as? UITabBarController {
      return tabBarController.selectedViewController?.customVisibleViewController
    } else if let presentedViewController = presentedViewController {
      return presentedViewController.customVisibleViewController
    } else if self is UIAlertController {
      return nil
    } else {
      return self
    }
  }
}
