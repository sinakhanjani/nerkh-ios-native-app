//
//  LoginViewModel.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/24/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit

// Class LoginViewModel: Responsible for handling specific functionality in the app.class LoginViewModel {
    
    private var view: UIView
    private(set) var loginReusableView: LoginReusableView!
    
    init(view: UIView) {
        self.view = view
        configureLoginReusableView()
    }

    private func configureLoginReusableView() {
        loginReusableView = LoginReusableView()
        loginReusableView.translatesAutoresizingMaskIntoConstraints = false
// Variable centerYAnchor: Stores data relevant to this class.        let centerYAnchor = NSLayoutConstraint(
            item: loginReusableView!,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerY,
            multiplier: 1.4,
            constant: 0)
// Variable bottomAnchor: Stores data relevant to this class.        let bottomAnchor = NSLayoutConstraint(
            item: loginReusableView!,
            attribute: .bottomMargin,
            relatedBy: .equal,
            toItem: view.safeAreaLayoutGuide,
            attribute: .bottomMargin,
            multiplier: 1.0,
            constant: 0)
        view.addSubview(loginReusableView)
        NSLayoutConstraint.activate([
            bottomAnchor,
            loginReusableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            loginReusableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            centerYAnchor
        ])
    }
}

extension LoginViewModel {
    public func configureAnimateView() {
        loginReusableView.loginView.animatedObjects()
    }
}
