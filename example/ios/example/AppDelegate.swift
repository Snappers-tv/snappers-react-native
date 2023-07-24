import UIKit
import React
#if DEBUG && FB_SONARKIT_ENABLED
import FlipperKit
#endif
import Snappers
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RCTBridgeDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    initializeFlipper(with: application)

    let bridge = RCTBridge(delegate: self, launchOptions: launchOptions)
    let rootView = RCTRootView(bridge: bridge!, moduleName: "example", initialProperties: nil)

    if #available(iOS 13.0, *) {
      rootView.backgroundColor = UIColor.systemBackground
    } else {
      rootView.backgroundColor = UIColor.white
    }

    window = UIWindow(frame: UIScreen.main.bounds)
    let rootViewController = UIViewController()
    rootViewController.view = rootView
    window?.rootViewController = rootViewController
    window?.makeKeyAndVisible()

    let snappersConfig = SnappersConfiguration(affiliateCode: "AFFILIATE_CODE", affiliateSecret: "AFFILIATE_SECRET" ,disableBackgroundLocationRequest: true, allowSnappersdismissal: true)


    SnappersSDK.configure(configuration: snappersConfig, application: application, launchOptions: launchOptions) { error  in
      guard error == nil else {
        print("Error configuring snappers", error!)
        return
       }
        print("Snappers configured successfully")
    }



    UNUserNotificationCenter.current().delegate = self


    return true
  }

  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey :
  Any] = [:]) -> Bool {
      SnappersSDK.open(app: app, url: url, options: options)
  }


  func sourceURL(for bridge: RCTBridge!) -> URL! {
    #if DEBUG
    return RCTBundleURLProvider.sharedSettings()?.jsBundleURL(forBundleRoot: "index", fallbackResource: nil)
    #else
    return Bundle.main.url(forResource: "main", withExtension: "jsbundle")
    #endif
  }

  private func initializeFlipper(with application: UIApplication) {
    #if DEBUG && FB_SONARKIT_ENABLED
    let client = FlipperClient.shared()
    let layoutDescriptionMapper = SKDescriptorMapper(defaults: ())
    client?.add(FlipperKitLayoutPlugin(rootNode: application, with: layoutDescriptionMapper))
    client?.add(FKUserDefaultsPlugin(suiteName: nil))
    client?.add(FlipperKitReactPlugin())
    client?.add(FlipperKitNetworkPlugin(networkAdapter: SKIOSNetworkAdapter()))
    client?.start()
    #endif
  }

  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
       //This is needed to make sure your Token is registered with the APN
       Messaging.messaging().token { token, error in
         if let error = error {
           print("Error fetching remote FCM registration token: \(error)")
         } else if let token = token {
           print("Remote instance ID token: \(token)")
         }
       }
   }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .banner, .sound]);
    }
}
