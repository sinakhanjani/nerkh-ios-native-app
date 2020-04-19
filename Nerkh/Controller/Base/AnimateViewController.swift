//
//  AnimateViewController.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/27/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit

class AnimateViewController: BaseViewController {
    
    public var backgroundView: UIView = {
        let view = UIView()
        view.frame = UIScreen.main.bounds
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            view.backgroundColor = .white
        }
        view.alpha = 0.0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
    }
}

extension AnimateViewController {
    // MARK: --- animating background opacity ---
    internal func animateBackgroundOpacity(_ backgroundView: UIView, endAnimate: Bool = false, alpha: CGFloat = 0.0) {
        if endAnimate {
            UIView.animate(withDuration: 0.6, animations: {
                backgroundView.alpha = 0.0
            }) { state in
                backgroundView.removeFromSuperview()
            }
        }
        if !endAnimate {
            backgroundView.alpha = 1.0-0.2-alpha
        }
    }
    
    internal func configureBackgroundView() {
        if let presentingViewController = self.presentingViewController {
            presentingViewController.view.addSubview(backgroundView)
            presentingViewController.view.bringSubviewToFront(backgroundView)
            UIView.animate(withDuration: 0.6) {
                self.backgroundView.alpha = 0.8
            }
        }
    }
}
