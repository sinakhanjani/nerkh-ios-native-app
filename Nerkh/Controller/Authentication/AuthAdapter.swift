//
//  AuthAdapter.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/23/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import Foundation
 class AuthAdapter {
    enum LoginMethod {
        case google, phone
    }
    
    private var presenter: LoginViewController
    
    public var coordinator: Coordinator!
    
    public var loginMethod: LoginMethod? {
        willSet {
            guard let loginMethod = newValue else {
                fatalError("Login Method not set.")
            }
            if loginMethod == .google {
                self.coordinator = GoogleLoginAdapter(presenter: presenter)
            } else {
                // another login method
            }
        }
    }

    init(presenter: LoginViewController) {
        self.presenter = presenter
    }
}
