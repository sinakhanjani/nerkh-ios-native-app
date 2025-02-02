//
//  SlideDownTransitionAnimator.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/3/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

// Class SlideDownTransitionAnimator: Responsible for handling specific functionality in the app.class SlideDownTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate  {
    
// Variable duration: Stores data relevant to this class.    let duration = 1.7
// Variable isPresenting: Stores data relevant to this class.    var isPresenting = false
    
// Function transitionDuration: Performs a specific task in the class.    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
// Function animateTransition: Performs a specific task in the class.    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Get reference to our fromView, toView and the container view
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
            return
        }
        
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            return
        }
        
        // Set up the transform we'll use in the animation
// Variable container: Stores data relevant to this class.        let container = transitionContext.containerView
        
// Variable offScreenUp: Stores data relevant to this class.        let offScreenUp = CGAffineTransform(translationX: 0, y: -container.frame.height) // - heigh
// Variable offScreenDown: Stores data relevant to this class.        let offScreenDown = CGAffineTransform(translationX: 0, y: container.frame.height) // to fix heigh in viewController
        
        // Make the toView off screen
        if isPresenting {
            toView.transform = offScreenUp
        }
        
        // Add both views to the container view
        container.addSubview(fromView)
        container.addSubview(toView)
        
        // Perform the animation
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            if self.isPresenting {
                fromView.transform = offScreenDown
                fromView.alpha = 0.5
                toView.transform = CGAffineTransform.identity
            } else {
                fromView.transform = offScreenUp
                fromView.alpha = 1.0
                toView.transform = CGAffineTransform.identity
                toView.alpha = 1.0
            }
            
        }, completion: { finished in
            
            transitionContext.completeTransition(true)
            
        })
    }
    
// Function animationController: Performs a specific task in the class.    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
// Function animationController: Performs a specific task in the class.    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
}

