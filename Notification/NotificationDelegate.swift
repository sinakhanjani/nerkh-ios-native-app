//
//  AppNotiticationDelegate.swift
//  Nerkh
//
//  Created by Sina khanjani on 12/23/1398 AP.
//  Copyright © 1398 Sina Khanjani. All rights reserved.
//

import Foundation
import UserNotifications
import UserNotificationsUI

// Class NotificationDelegate: Responsible for handling specific functionality in the app.class NotificationDelegate: NSObject , UNUserNotificationCenterDelegate {
    
    @available(iOS 10.0, *)
// Function userNotificationCenter: Performs a specific task in the class.    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.badge,.sound])
    }
    
// Function userNotificationCenter: Performs a specific task in the class.    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        print("openSettingsForNotification")
    }

    static func parseNotification(_ userInfo: [AnyHashable: Any], _ rootViewController: UIViewController) {
// Function present: Performs a specific task in the class.        func present(dict: NSDictionary, userInfo: [AnyHashable: Any]) {
// Variable nerkh: Stores data relevant to this class.            let nerkh = Notify(storyboardID: dict["storyboardID"] as? String, duration: dict["duration"] as? Int ?? 0, webURL: dict["webURL"] as? String, mobile: dict["mobile"] as? String, telephone: dict["telephone"] as? String, type: userInfo["type"] as? String, imageURL: userInfo["imageURL"] as? String, title: userInfo["title"] as? String, body: userInfo["body"] as? String, message: dict["message"] as? String, nerkh: dict["nerkh"] as? String, chart: userInfo["chart"] as? String)
            if let storyboardID = nerkh.storyboardID {
// Variable vc: Stores data relevant to this class.                let vc = UIViewController.create(withId: storyboardID)
                rootViewController.present(vc, animated: true, completion: nil)
                if nerkh.duration == 0 {
                    // this viewController never dismissed automaticality.
                } else {
                    // viewController dismissed automaticality.
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+Double(nerkh.duration)) {
                        vc.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
        if let notification = userInfo["source"] as? String,
// Variable jsonData: Stores data relevant to this class.            let jsonData = notification.data(using: .utf8),
// Variable dict: Stores data relevant to this class.            let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? NSDictionary {
            present(dict: dict, userInfo: userInfo)
            print("APS PAYLOAD DICTIONARY \(dict)")
        }
    }
}
