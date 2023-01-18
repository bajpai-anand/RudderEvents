//
//  RuuderEventTracker.swift
//  experi3frame
//
//  Created by anand on 13/01/23.
//

import UIKit
import SwiftUI

public class RudderEventTracker {
  
  public static let shared = RudderEventTracker()
  
  private let rSUi = RudderSwiftUi()
  
  private init() { }
  
  public func addRudderEventTapGesture() {
    let globalGesture = UITapGestureRecognizer(target: self, action: #selector(globalTapped))
    globalGesture.numberOfTapsRequired = 2
    UIApplication.shared.getKeyWindow()?.addGestureRecognizer(globalGesture)
  }
  
  @objc func globalTapped() {
    
    let swiftUIController = UIHostingController(rootView: rSUi)
    UIApplication.topViewController()?.navigationController?.present(swiftUIController, animated: true)
  }
  
  public func addDataToList(data: AnalyticsData) {
    rSUi.viewModel.addDataIntoArray(analyticsData: data)
  }
  
}


extension UIApplication {
  
  func getKeyWindow() -> UIWindow? {
    if #available(iOS 13.0, *) {
      let windowScenes = self.connectedScenes.compactMap({ $0 as? UIWindowScene })
      if let windowScene = windowScenes.first(where: { $0.activationState == .foregroundActive }),
         let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
        return keyWindow
      }
      
      return nil
    }
    else {
      return UIApplication.shared.keyWindow
    }
  }
  
  class func topViewController(controller: UIViewController? = UIApplication.shared.getKeyWindow()?.rootViewController) -> UIViewController? {
    if let navigationController = controller as? UINavigationController {
      return topViewController(controller: navigationController.visibleViewController)
    }
    if let tabController = controller as? UITabBarController {
      if let selected = tabController.selectedViewController {
        return topViewController(controller: selected)
      }
    }
    if let presented = controller?.presentedViewController {
      return topViewController(controller: presented)
    }
    return controller
  }
  
}