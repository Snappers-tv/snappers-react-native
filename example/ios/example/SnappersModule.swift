//
//  SnappersModule.swift
//  SnappersModule
//
//  Copyright © 2022 Snappers. All rights reserved.
//

import Foundation
import Snappers

@objc(SnappersModule)
class SnappersModule: NSObject {
  
  @objc
  func launch() -> Void {
    print("mlem")
    
    DispatchQueue.main.async {
      SnappersSDK.present(from: self.getTopMostViewController(), animated: false)
    }
    
  }
  
  func getTopMostViewController() -> UIViewController? {
          var topMostViewController = UIApplication.shared.keyWindow?.rootViewController
          while let presentedViewController = topMostViewController?.presentedViewController {
              topMostViewController = presentedViewController
          }
          return topMostViewController
  }

  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
