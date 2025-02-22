//
//  AppDelegate.swift
//  Nerkh
//
//  Created by Sina khanjani on 12/15/1398 AP.
//  Copyright © 1398 Sina Khanjani. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseMessaging
import UserNotifications
import MobileCoreServices
import BackgroundTasks
import GoogleSignIn

protocol NotificationAppDelegate {
// Function recievedNotification: Performs a specific task in the class.    func recievedNotification(userInfo: [AnyHashable : Any])
}

@UIApplicationMain
// Class AppDelegate: Responsible for handling specific functionality in the app.class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    public var window: UIWindow?
    public var fcmToken = ""
    
// Variable delegate:: Stores data relevant to this class.    var delegate: NotificationAppDelegate?
        
// Function application: Performs a specific task in the class.    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {
            // ---> Use SceneDelegate <---
            registerBackgroundTaks()
        } else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = UITabBarController.create()
            self.window?.makeKeyAndVisible()
            FirebaseApp.configure()
            Messaging.messaging().delegate = self
        }
        application.applicationIconBadgeNumber = 0
        setupPushNotification(application)
        configuration()
        GIDSignIn.sharedInstance().clientID = "1067153044179-o76t5l5q5hai7spqlcs24tvb1lp21pna.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        return true
    }
    
// Function applicationWillTerminate: Performs a specific task in the class.    func applicationWillTerminate(_ application: UIApplication) {
        WebSocket.default.close()
    }
    
    // MARK: - Google-Sign
// Function application: Performs a specific task in the class.    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
        print(GIDSignIn.sharedInstance().handle(url))
        return GIDSignIn.sharedInstance().handle(url)
    }
//
// Function sign: Performs a specific task in the class.    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        //
    }
//
// Function sign: Performs a specific task in the class.    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
    }

    // MARK: URL
// Function configuration: Performs a specific task in the class.    func configuration() {
// Variable baseAbsoluteURLString:: Stores data relevant to this class.        let baseAbsoluteURLString: String = "http://194.5.207.132/"
        UserDefaults.standard.set(baseAbsoluteURLString, forKey: "_baseURL")
    }
    
    // MARK: FCM Push Notification
    @available(iOS 10.0, *)
// Function setupPushNotification: Performs a specific task in the class.    func setupPushNotification(_ application: UIApplication) {
// Variable notificationDelegate: Stores data relevant to this class.        let notificationDelegate = NotificationDelegate()
// Variable center: Stores data relevant to this class.        let center = UNUserNotificationCenter.current()
        center.delegate = notificationDelegate
// Function nerkhNotificationCategory: Performs a specific task in the class.        func nerkhNotificationCategory() -> UNNotificationCategory {
// Variable openAction: Stores data relevant to this class.            let openAction = UNNotificationAction(identifier: "Notification.push.open", title: NSLocalizedString("Open", comment: "open an application"), options: .foreground)
// Variable deafultCategory: Stores data relevant to this class.            let deafultCategory = UNNotificationCategory(identifier: "Notification.category.nerkh", actions: [openAction], intentIdentifiers: [], options: [])
            return deafultCategory
        }
// Function advertiseNotificationCategory: Performs a specific task in the class.        func advertiseNotificationCategory() -> UNNotificationCategory {
// Variable openAction: Stores data relevant to this class.            let openAction = UNNotificationAction(identifier: "Notification.push.open", title: NSLocalizedString("Open", comment: "open an application"), options: .foreground)
// Variable deafultCategory: Stores data relevant to this class.            let deafultCategory = UNNotificationCategory(identifier: "Notification.category.advertise", actions: [openAction], intentIdentifiers: [], options: [])
            return deafultCategory
        }
// Function chartNotificationCategory: Performs a specific task in the class.        func chartNotificationCategory() -> UNNotificationCategory {
// Variable deafultCategory: Stores data relevant to this class.            let deafultCategory = UNNotificationCategory(identifier: "Notification.category.chart", actions: [], intentIdentifiers: [], options: [])
            return deafultCategory
        }
        center.setNotificationCategories(Set([nerkhNotificationCategory(),advertiseNotificationCategory(),chartNotificationCategory()]))
// Variable authOptions:: Stores data relevant to this class.        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
        application.registerForRemoteNotifications()
    }
    
// Function messaging: Performs a specific task in the class.    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        InstanceID.instanceID().instanceID { (result, error) in
          if let error = error {
            print("Error fetching remote instance ID: \(error)")
          } else if let result = result {
            print("Remote instance ID token: \(result.token)")
          }
        }
        print("Firebase registration token: \(fcmToken)")
// Variable dataDict:[String:: Stores data relevant to this class.        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        self.fcmToken = fcmToken
    }
    
// Function application: Performs a specific task in the class.    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
// Variable tokenParts: Stores data relevant to this class.        let tokenParts = deviceToken.map { data -> String in
            return String.init(format: "%02.2hhx", data)
        }
// Variable token: Stores data relevant to this class.        let token = tokenParts.joined()
        print("didRegisterForRemoteNotificationsWithDeviceToken")
        print("Push Notification Token: \(token)")
        Messaging.messaging().apnsToken = deviceToken
    }
    
// Function application: Performs a specific task in the class.    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if #available(iOS 13.0, *) {
            delegate?.recievedNotification(userInfo: userInfo)
        }
        if let rootViewController = window?.rootViewController {
            NotificationDelegate.parseNotification(userInfo, rootViewController)
        }
        completionHandler(.newData)
    }

// Function application: Performs a specific task in the class.    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Registration failed!")
    }
    
    // MARK: Topics ----
// Function addtoTopic: Performs a specific task in the class.    func addtoTopic(to: String) {
        Messaging.messaging().subscribe(toTopic: to) { (err) in
            print("Subscribed to \(to) topic")
        }
    }
    
// Function removetoTopic: Performs a specific task in the class.    func removetoTopic(from: String) {
        Messaging.messaging().unsubscribe(fromTopic: from) { (err) in
            if err == nil {
                print("Unsubscribe to \(from) topic")
            }
        }
    }
    
    // MARK: Background Fetch
// Function application: Performs a specific task in the class.    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // <---- Update appliaction in background fetch 0--->
        completionHandler(.noData)
    }
    
    //MARK: Regiater BackGround Tasks
    @available(iOS 13.0, *)
    private func registerBackgroundTaks() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "background.nerkh.refresh", using: nil) { task in
            //This task is cast with processing request (BGProcessingTask)
            SceneDelegate.handleAppRefreshTask(task: task as! BGAppRefreshTask)
        }
    }
    
    
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
// Function application: Performs a specific task in the class.    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
// Function application: Performs a specific task in the class.    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack
    @available(iOS 13.0, *)
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
// Variable container: Stores data relevant to this class.        let container = NSPersistentCloudKitContainer(name: "Nerkh")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    @available(iOS 13.0, *)
// Function saveContext: Performs a specific task in the class.    func saveContext () {
// Variable context: Stores data relevant to this class.        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
// Variable nserror: Stores data relevant to this class.                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    static func appDelegate() -> AppDelegate {
// Variable appDelegate: Stores data relevant to this class.        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate
    }
}

extension AppDelegate: MessagingDelegate {}
