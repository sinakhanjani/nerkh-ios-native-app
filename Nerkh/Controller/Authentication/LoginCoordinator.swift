//
//  LoginCoordinator.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/23/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    private var presenter: UIViewController
    private var interactor: Interactor
    private let animated: Bool

    private lazy var loginViewController: LoginViewController = {
        let vc = self.create(animated: animated)
        return vc
    }()

    init(presenter: UIViewController, interactor: Interactor, animated: Bool = true) {
        self.animated = animated
        self.presenter = presenter
        self.interactor = interactor
    }
    
    private func create(animated: Bool = false) -> LoginViewController {
        let vc = LoginViewController.create()
        vc.view.backgroundColor = .clear
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }
    
    public func start() {
        loginViewController.transitioningDelegate = presenter as? UIViewControllerTransitioningDelegate
        loginViewController.interactor = interactor
        presenter.present(loginViewController, animated: true, completion: nil)
    }
}

extension LoginCoordinator: LoginCoordinatorInjection {
    typealias T = LoginViewController
}
