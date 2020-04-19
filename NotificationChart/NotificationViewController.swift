//
//  NotificationViewController.swift
//  NotificationChart
//
//  Created by Sina khanjani on 12/24/1398 AP.
//  Copyright © 1398 Sina Khanjani. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    private var userInfo: [AnyHashable: Any]?
    private let baseAbsoluteURLString = "http://194.5.207.132/"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func didReceive(_ notification: UNNotification) {
        let content = notification.request.content
        self.userInfo = content.userInfo
    }
    
    @IBAction func centerButtonTapped(_ sender: Any) {
        func presentActivity(any: [Any]) {
            let activityController = UIActivityViewController(activityItems: any, applicationActivities: nil)
            DispatchQueue.main.async {
                self.present(activityController, animated: true, completion: nil)
            }
        }
        let notification = userInfo?["source"] as? String
        if let jsonData = notification?.data(using: .utf8) {
            let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? NSDictionary
            let message = dict?["message"] as? String
            if let message = message {
                presentActivity(any: [message])
            }
        } else {
            let captureImage = view.asImage()
            presentActivity(any: [captureImage])
        }
    }
}
