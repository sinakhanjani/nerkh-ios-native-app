//
//  PopTransitionAnimator.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/3/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

// Class PopTransitionAnimator: Responsible for handling specific functionality in the app.class PopTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
// Variable duration: Stores data relevant to this class.    let duration = 2.0
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
        
// Variable minimize: Stores data relevant to this class.        let minimize = CGAffineTransform(scaleX: 0, y: 0)
// Variable offScreenDown: Stores data relevant to this class.        let offScreenDown = CGAffineTransform(translationX: 0, y: container.frame.height)
// Variable shiftDown: Stores data relevant to this class.        let shiftDown = CGAffineTransform(translationX: 0, y: 15)
// Variable scaleDown: Stores data relevant to this class.        let scaleDown = shiftDown.scaledBy(x: 0.95, y: 0.95)
        
        // Change the initial size of the toView
        toView.transform = minimize
        
        // Add both views to the container view
        if isPresenting {
            container.addSubview(fromView)
            container.addSubview(toView)
        } else {
            container.addSubview(toView)
            container.addSubview(fromView)
        }
        
        // Perform the animation
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            
            if self.isPresenting {
                fromView.transform = scaleDown
                fromView.alpha = 0.5
                toView.transform = CGAffineTransform.identity
            } else {
                fromView.transform = offScreenDown
                toView.alpha = 1.0
                toView.transform = CGAffineTransform.identity
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
