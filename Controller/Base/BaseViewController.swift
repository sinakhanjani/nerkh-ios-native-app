//
//  BaseViewController.swift
//  Nerkh
//
//  Created by Sina khanjani on 12/15/1398 AP.
//  Copyright © 1398 Sina Khanjani. All rights reserved.
//

import UIKit
import UserNotifications
import Network

// Class BaseViewController: Responsible for handling specific functionality in the app.class BaseViewController: NetworkViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    public func setupUI() {
        NotificationCenter.default.addObserver(self, selector: #selector(didChangedReference), name: Reference.default.didChangedReference, object: nil)
        UNUserNotificationCenter.current().delegate = self
    }
    
    @objc private func didChangedReference() {
        NotificationCenter.default.removeObserver(self)
// Variable parent: Stores data relevant to this class.        let parent = self.view.superview
        self.view.removeFromSuperview()
        self.view = nil
        parent?.addSubview(view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning: \(String(describing: self))")
    }
}

extension BaseViewController: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}
