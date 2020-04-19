//
//  NotificationViewController.swift
//  NotificationAdvertise
//
//  Created by Sina khanjani on 12/23/1398 AP.
//  Copyright © 1398 Sina Khanjani. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var titleLabel: MyLabel!
    @IBOutlet weak var descriptionLabel: MyLabel!
    
    private var userInfo: [AnyHashable: Any]?
    private let baseAbsoluteURLString = "http://194.5.207.132/"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func didReceive(_ notification: UNNotification) {
        let content = notification.request.content
        self.userInfo = content.userInfo
        DispatchQueue.main.async {
            self.descriptionLabel.text = content.body
            self.titleLabel.text = content.title
        }
        if let urlImageString = userInfo?["imageURL"] as? String {
            if let url = URL(string: baseAbsoluteURLString + urlImageString) {
                URLSession.downloadImage(atURL: url) { [weak self] (data, error) in
                    if let _ = error {
                        return
                    }
                    guard let data = data else {
                        return
                    }
                    DispatchQueue.main.async {
                        self?.bannerImageView.image = UIImage(data: data)
                    }
                }
            }
        }
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

extension URLSession {
    class func downloadImage(atURL url: URL, withCompletionHandler completionHandler: @escaping (Data?, NSError?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            completionHandler(data, nil)
        }
        dataTask.resume()
    }
}
