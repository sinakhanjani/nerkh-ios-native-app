//
//  RoundedView.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/4/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit

@IBDesignable
class BaseView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    func setupUI() {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupUI()
    }
}

