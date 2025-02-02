//
//  DismissAnimator.swift
//  Together
//
//  Created by Sina khanjani on 10/17/19.
//  Copyright © 2019 Sina khanjani. All rights reserved.
//


import UIKit

// Class DismissAnimator: Responsible for handling specific functionality in the app.class DismissAnimator: NSObject { }

extension DismissAnimator: UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate {
// Function transitionDuration: Performs a specific task in the class.    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }

// Function animateTransition: Performs a specific task in the class.    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
// Variable key: Stores data relevant to this class.        let key = UITransitionContextViewControllerKey.from
        guard let from = transitionContext.viewController(forKey: key) else {
            return
        }
// Variable screenBounds: Stores data relevant to this class.        let screenBounds = UIScreen.main.bounds
// Variable bottomLeftCorner: Stores data relevant to this class.        let bottomLeftCorner = CGPoint(x: 0, y: screenBounds.height)
// Variable finalFrame: Stores data relevant to this class.        let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                from.view.frame = finalFrame
            },
            completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}
