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
    DispatchQueue.main.async {
      SnappersSDK.present()
    }
    
  }

  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
