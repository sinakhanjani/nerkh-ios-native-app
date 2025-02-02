//
//  ShadowView.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/4/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit


// Class ShadowView: Responsible for handling specific functionality in the app.class ShadowView: BaseView {
    override func awakeFromNib() {
        super.awakeFromNib()
        super.setupUI()
        setupShadow()
    }
    
    @IBInspectable var shadowSize: CGFloat = 0.0 {
        didSet {
            setupShadow()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) {
        didSet {
            setupShadow()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            setupShadow()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            setupShadow()
        }
    }
    
// Function setupShadow: Performs a specific task in the class.    func setupShadow() {
        layoutIfNeeded()
// Variable shadowPath: Stores data relevant to this class.        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: frame.width + shadowSize,
                                                   height: frame.height + shadowSize))
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        super.setupUI()
        setupShadow()
    }
}

