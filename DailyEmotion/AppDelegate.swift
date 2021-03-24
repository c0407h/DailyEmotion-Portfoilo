//
//  AppDelegate.swift
//  DailyEmotion
//
//  Created by 이충현 on 2021/03/08.
//

import UIKit
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport



@main
//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func requestIDFA() {
      ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
        // Tracking authorization completed. Start loading ads here.
        // loadAd()
      })
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        Thread.sleep(forTimeInterval: 0.2)
        
        let status = ATTrackingManager.trackingAuthorizationStatus
        print(status.rawValue)
        // 최초는 .notDetermined 상태
        ATTrackingManager.requestTrackingAuthorization { status in switch status {
        case .authorized: print("성공")
        case .denied: print("해당 앱 추적 권한 거부 또는 아이폰 설정->개인정보보호->추적 거부 상태")
        case .notDetermined: print("승인 요청을 받기전 상태 값")
        case .restricted: print("앱 추적 데이터 사용 권한이 제한된 경우")
        @unknown default: print("에러 처리..")
            
        }

        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

