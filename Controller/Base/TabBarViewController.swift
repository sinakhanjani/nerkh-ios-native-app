//
//  AppViewController.swift
//  Nerkh
//
//  Created by Sina khanjani on 12/15/1398 AP.
//  Copyright © 1398 Sina Khanjani. All rights reserved.
//

import UIKit

// Class TabBarViewController: Responsible for handling specific functionality in the app.class TabBarViewController: BaseViewController {
    
    private var loginCoordinator: LoginCoordinator {
// Variable loginCoordinator: Stores data relevant to this class.        let loginCoordinator = LoginCoordinator(presenter: self, interactor: interactor)
        return loginCoordinator
    }
    
    internal let interactor: Interactor = Interactor()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
        addMenuBarButton()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.isTranslucent = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        prepareForLaunchApplication()
    }

    // MARK: @IBAction
    @objc func menuButtonTapped(_ sender: UIBarButtonItem) {
// Variable vc: Stores data relevant to this class.        let vc = MenuViewController.nav()
        present(vc, animated: true, completion: nil)
    }

    // MARK: Method
// Function prepareForLaunchApplication: Performs a specific task in the class.    func prepareForLaunchApplication() {
        guard UserDefaults.standard.bool(forKey: "WalkThroughViewController") else {
            present(WalkThroughViewController.create(), animated: true, completion: nil)
            return
        }
        guard UserDefaults.standard.bool(forKey: "LoginViewController") else {
            loginCoordinator.start()
            return
        }
    }

    internal func addMenuBarButton() {
// Variable rightBarButtonItem: Stores data relevant to this class.        let rightBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(menuButtonTapped(_:)))
        rightBarButtonItem.image = UIImage(systemName: "text.justify", compatibleWith: traitCollection)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationController?.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}

extension TabBarViewController: UIViewControllerTransitioningDelegate {
// Function animationController: Performs a specific task in the class.    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }

// Function interactionControllerForDismissal: Performs a specific task in the class.    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}
