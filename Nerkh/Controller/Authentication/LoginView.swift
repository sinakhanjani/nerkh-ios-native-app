//
//  LoginView.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/24/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit
import Lottie

class LoginView: UIView {
    
    @IBOutlet weak var loginStackView: UIStackView!
    
    private let animationView = AnimationView()
    public var animated: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cornerRadius(corners: [.topLeft,.topRight], radius: 48)
    }
}

extension LoginView {
    private func setupAnimatingStackView() {
        loginStackView.subviews[1].transform = CGAffineTransform(translationX: 0, y: -200)
        loginStackView.subviews[2].transform = CGAffineTransform(translationX: 0, y: -200)
        loginStackView.subviews[3].transform = CGAffineTransform(translationX: 0, y: -60)
        loginStackView.subviews[3].alpha = 0
        loginStackView.subviews[0].alpha = 0
        animationView.alpha = 0
        UIView.animateKeyframes(withDuration: 1.9, delay: 0.2, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.4, animations: {
                self.loginStackView.subviews[1].alpha = 1.0
                self.loginStackView.subviews[1].transform = CGAffineTransform.identity
                self.animationView.alpha = 1
            })
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.6, animations: {
                self.loginStackView.subviews[0].alpha = 1.0
                self.loginStackView.subviews[2].alpha = 1.0
                self.loginStackView.subviews[2].transform = CGAffineTransform.identity
            })
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.6, animations: {
                self.loginStackView.subviews[3].alpha = 1.0
                self.loginStackView.subviews[3].transform = CGAffineTransform.identity
            })
        }, completion: { status in
            self.animated = false
        })
    }
    
    private func setupAnimatingLottieView() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        superview?.addSubview(animationView)
        let height:CGFloat = 200.0
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalToConstant: height),
            animationView.heightAnchor.constraint(equalToConstant: height),
            animationView.topAnchor.constraint(equalTo: self.topAnchor, constant: -height),
            animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        let animation = Animation.named("login")
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        let endAnimationProgressTime: AnimationProgressTime = 1
        let startAnimationProgressTime: AnimationProgressTime = 0.4
        animationView.play(fromProgress: startAnimationProgressTime, toProgress: endAnimationProgressTime, loopMode: .loop) { status in
            //
        }
    }
    
    public func animatedObjects() {
        if animated {
            setupAnimatingStackView()
            setupAnimatingLottieView()
        }
    }
}
