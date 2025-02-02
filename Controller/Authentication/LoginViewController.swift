//
//  LoginViewController.swift
//  Nerkh
//
//  Created by Sina khanjani on 12/15/1398 AP.
//  Copyright © 1398 Sina Khanjani. All rights reserved.
//

import UIKit
import Lottie

// Class LoginViewController: Responsible for handling specific functionality in the app.class LoginViewController: AnimateViewController {
    
    private(set) var viewModel: LoginViewModel!
    private(set) var authAdapter: AuthAdapter!

    internal var interactor: Interactor! {
        didSet {
            viewModel = LoginViewModel(view: view)
            viewModel.loginReusableView.delegate = self
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    override func setupUI() {
        super.setupUI()
        authAdapter = AuthAdapter(presenter: self)
        configureGestureRecognizer()
    }
}

// MARK: - Method
extension LoginViewController {
    private func updateUI() {
        viewModel.configureAnimateView()
        configureBackgroundView()
    }
}

extension LoginViewController {
    private func configureGestureRecognizer() {
// Variable handleGestureRecognizer: Stores data relevant to this class.        let handleGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        view.addGestureRecognizer(handleGestureRecognizer)
    }
    
    @objc private func handleGesture(_ sender: UIPanGestureRecognizer) {
// Variable percentThreshold:CGFloat: Stores data relevant to this class.        let percentThreshold:CGFloat = 0.36
// Variable translation: Stores data relevant to this class.        let translation = sender.translation(in: view)
// Variable verticalMovement: Stores data relevant to this class.        let verticalMovement = translation.y / view.bounds.height
// Variable downwardMovement: Stores data relevant to this class.        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
// Variable downwardMovementPercent: Stores data relevant to this class.        let downwardMovementPercent = fminf(downwardMovement, 1.0)
// Variable progress: Stores data relevant to this class.        let progress = CGFloat(downwardMovementPercent)
        switch sender.state {
        case .began:
            showHelperCircle(to: view)
            interactor.hasStarted = true
            dismiss(animated: true, completion: nil)
        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            animateBackgroundOpacity(backgroundView, alpha: progress)
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            animateBackgroundOpacity(backgroundView, endAnimate: interactor.shouldFinish)
            interactor.hasStarted = false
            interactor.shouldFinish ? interactor.finish() : interactor.cancel()
        default:
            break
        }
    }
}

extension LoginViewController: HintInjection { }

// MARK: - LoginReusableViewDelegate Delegation:
extension LoginViewController: LoginReusableViewDelegate {
    // - @IBAction Button 
// Function gAuthButtonTapped: Performs a specific task in the class.    func gAuthButtonTapped(_ sender: UIButton) {
        authAdapter.loginMethod = .google
        authAdapter.coordinator.start()
    }
    
// Function phoneAuthButtonTapped: Performs a specific task in the class.    func phoneAuthButtonTapped(_ sender: UIButton) {
        authAdapter.loginMethod = .phone
        authAdapter.coordinator.start()
    }
}
