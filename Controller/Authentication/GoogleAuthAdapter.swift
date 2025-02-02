//
//  LoginAdapter.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/23/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import GoogleSignIn
import NetworkAPI

// Class GoogleLoginAdapter: Responsible for handling specific functionality in the app.class GoogleLoginAdapter: NSObject, GIDSignInDelegate, Coordinator {
    
    private var presenter: LoginViewController
    
    init(presenter: LoginViewController) {
        self.presenter = presenter
        super.init()
        self.setupGoogleAuth()
    }
    
    private func setupGoogleAuth() {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().presentingViewController = presenter
    }
    
    public func start() {
        GIDSignIn.sharedInstance().signIn()
    }
    
// Function sign: Performs a specific task in the class.    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        //- GoogleAuth - Send
        struct GoogleAuth: Codable {
// Variable username,: Stores data relevant to this class.            let username, name, family, fcmToken: String
// Variable reference:: Stores data relevant to this class.            let reference: String
// Variable operationSystem:: Stores data relevant to this class.            let operationSystem: OperationSystem
        }
        if let error = error {
          if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
            print("The user has not signed in before or they have since sign out.")
          } else {
            print("\(error.localizedDescription)")
          }
          return
        }
        // Perform any operations on signed in user here.
// Variable _: Stores data relevant to this class.        let _ = user.userID  ?? "user_* "// For client-side use only!
// Variable name: Stores data relevant to this class.        let name = user.profile.name  ?? "username_*"
// Variable familyName: Stores data relevant to this class.        let familyName = user.profile.familyName ?? "family_*"
// Variable email: Stores data relevant to this class.        let email = user.profile.email ?? "email_*"
// Variable operationSystem: Stores data relevant to this class.        let operationSystem = OperationSystem(platform: "iOS", phone: "iPhone'X", appVersion: "0.1.1", osVersion: "13.1.4", build: "1")
// Variable googleAuth: Stores data relevant to this class.        let googleAuth = GoogleAuth(username: email, name: name, family: familyName, fcmToken: UserDefaults.standard.value(forKey: "_fcmtoken") as! String, reference: "en", operationSystem: operationSystem)
        Network<Generic<GoogleAuthResponse>,GoogleAuth>(path: "api/user/google", ignoreAuth: true).addObject(googleAuth).post { (res) in
            res.ifSuccess { [unowned self = self] (data) in
                if data.error == false {
                    Authentication.default.authenticationUser(token: data.data.token, isLoggedIn: true)
                    UserDefaults.standard.set(true, forKey: "LoginViewController")
                    DispatchQueue.main.async {
// Variable vc: Stores data relevant to this class.                        let vc = self.presenter
                        self.stop(vc)
                    }
                }
            }
        }
        .dispose()
    }
}

extension GoogleLoginAdapter: LoginCoordinatorInjection {
    typealias T = LoginViewController
}
