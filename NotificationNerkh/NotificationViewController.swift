//
//  NotificationViewController.swift
//  NotificationNerkh
//
//  Created by Sina khanjani on 1/21/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: MyLabel!
    @IBOutlet weak var dateLabel: MyLabel!
    @IBOutlet weak var priceLabel: MyLabel!
    @IBOutlet weak var variationLabel: MyLabel!
    @IBOutlet weak var pointingLabel: MyLabel!
    @IBOutlet weak var titleLabel: MyLabel!
    
    private(set) var userInfo: [AnyHashable: Any]?
    private let baseAbsoluteURLString = "http://194.5.207.132/"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
        descriptionLabel.addLineSpacing(spaceLine: 8.0)
    }
    
    ///Decode a json format: { "price": Int,"variation": true, "percent": Double }
    func updateUI(nerkh: String?) {
        if let jsonData = nerkh?.data(using: .utf8) {
            DispatchQueue.main.async {
                let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? NSDictionary
                self.priceLabel.text = (dict?["price"] as? Int)?.seperateByCama
                if let variation = dict?["variation"] as? Bool, let percent = dict?["percent"] as? Double {
                    let color = variation ? UIColor.green:UIColor.red
                    self.pointingLabel.text = variation ? "▲":"▼"
                    self.variationLabel.text = "\(percent)"
                    self.priceLabel.textColor = color
                    self.pointingLabel.textColor = color
                    self.dateLabel.text = Date().PersianDate()
                }
            }
        }
    }
    
    @IBAction func centerButtonTapped(_ sender: UIButton) {
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
    
    func didReceive(_ notification: UNNotification) {
        let content = notification.request.content
        self.userInfo = content.userInfo
        DispatchQueue.main.async {
            self.descriptionLabel.text = content.body
            self.titleLabel.text = content.title
        }
        let notification = userInfo?["source"] as? String
        if let jsonData = notification?.data(using: .utf8) {
            let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? NSDictionary
            let nerkh = dict?["nerkh"] as? String
            updateUI(nerkh: nerkh)
        }
        if let urlImageString = content.userInfo["imageURL"] as? String {
            if let url = URL(string: baseAbsoluteURLString + urlImageString) {
                URLSession.downloadImage(atURL: url) { [weak self] (data, error) in
                    if let _ = error {
                        return
                    }
                    guard let data = data else {
                        return
                    }
                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }

    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            completion(.dismissAndForwardAction)
        case UNNotificationDefaultActionIdentifier:
            completion(.dismissAndForwardAction)
        case "Notification.push.open":
            completion(.dismissAndForwardAction)
        default:
            completion(.dismissAndForwardAction)
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

extension Int {
    var seperateByCama: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let nsNumber = NSNumber(value: self)
        let number = formatter.string(from: nsNumber)!
        return number
    }
}
