//
//  LoginViewController.swift
//  Nerkh
//
//  Created by Sina khanjani on 12/15/1398 AP.
//  Copyright © 1398 Sina Khanjani. All rights reserved.
//

import UIKit
import Lottie

class LoginViewController: AnimateViewController {
    
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
        let handleGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        view.addGestureRecognizer(handleGestureRecognizer)
    }
    
    @objc private func handleGesture(_ sender: UIPanGestureRecognizer) {
        let percentThreshold:CGFloat = 0.36
        let translation = sender.translation(in: view)
        let verticalMovement = translation.y / view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
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
    func gAuthButtonTapped(_ sender: UIButton) {
        authAdapter.loginMethod = .google
        authAdapter.coordinator.start()
    }
    
    func phoneAuthButtonTapped(_ sender: UIButton) {
        authAdapter.loginMethod = .phone
        authAdapter.coordinator.start()
    }
}
