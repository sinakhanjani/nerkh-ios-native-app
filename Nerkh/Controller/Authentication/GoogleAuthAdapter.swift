//
//  LoginAdapter.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/23/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import GoogleSignIn
import NetworkAPI

class GoogleLoginAdapter: NSObject, GIDSignInDelegate, Coordinator {
    
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
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        //- GoogleAuth - Send
        struct GoogleAuth: Codable {
            let username, name, family, fcmToken: String
            let reference: String
            let operationSystem: OperationSystem
        }
        if let error = error {
          if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
            print("The user has not signed in before or they have since signed out.")
          } else {
            print("\(error.localizedDescription)")
          }
          return
        }
        // Perform any operations on signed in user here.
        let _ = user.userID  ?? "user_* "// For client-side use only!
        let name = user.profile.name  ?? "username_*"
        let familyName = user.profile.familyName ?? "family_*"
        let email = user.profile.email ?? "email_*"
        let operationSystem = OperationSystem(platform: "iOS", phone: "iPhone'X", appVersion: "0.1.1", osVersion: "13.1.4", build: "1")
        let googleAuth = GoogleAuth(username: email, name: name, family: familyName, fcmToken: UserDefaults.standard.value(forKey: "_fcmtoken") as! String, reference: "en", operationSystem: operationSystem)
        Network<Generic<GoogleAuthResponse>,GoogleAuth>(path: "api/user/google", ignoreAuth: true).addObject(googleAuth).post { (res) in
            res.ifSuccess { [unowned self = self] (data) in
                if data.error == false {
                    Authentication.default.authenticationUser(token: data.data.token, isLoggedIn: true)
                    UserDefaults.standard.set(true, forKey: "LoginViewController")
                    DispatchQueue.main.async {
                        let vc = self.presenter
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
