//
//  AppDelegate.swift
//  Maps
//
//  Created by Роман далинкевич on 25.06.2021.
//

import UIKit
import GoogleMaps
import GooglePlaces
import YandexMapsMobile


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GMSMapViewDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
  
        //MARK: Please use your API keys
//      https://developers.google.com/maps/documentation/ios-sdk/overview
        GMSServices.provideAPIKey("Your google API Key")
//      https://tech.yandex.ru/maps/mapkit/doc/3.x/concepts/ios/quickstart-docpage/
        YMKMapKit.setApiKey("Your yandex API Key")

        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
}
