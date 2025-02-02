//
//  LoginCoordinatorInjection.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/25/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit

protocol LoginCoordinatorInjection {
    associatedtype T:LoginViewController
// Function stop: Performs a specific task in the class.    func stop(_ v:T)
}

extension LoginCoordinatorInjection {
// Function stop: Performs a specific task in the class.    func stop(_ v:T) {
        v.animateBackgroundOpacity(v.backgroundView, endAnimate: true)
        v.dismiss(animated: true, completion: nil)
    }
}
