//
//  CircleImageView.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/21/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit

@IBDesignable
// Class CircleImageView: Responsible for handling specific functionality in the app.class CircleImageView: UIImageView {
    
    @IBInspectable var cornerRadius : CGFloat = 0.0 {
        didSet {
            self.applyCornerRadius()
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor.clear{
        didSet {
            self.applyCornerRadius()
        }
    }
    
    @IBInspectable var borderWidth : Double = 0{
        didSet {
            self.applyCornerRadius()
        }
    }
    
    @IBInspectable var circular : Bool = false {
        didSet {
            self.applyCornerRadius()
        }
    }
    
    private func applyCornerRadius() {
        if (self.circular) {
            self.layer.cornerRadius = self.bounds.size.height / 2
            self.layer.masksToBounds = true
            self.layer.borderColor = self.borderColor.cgColor
            self.layer.borderWidth = CGFloat(self.borderWidth)
        } else {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
            self.layer.borderColor = self.borderColor.cgColor
            self.layer.borderWidth = CGFloat(self.borderWidth)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyCornerRadius()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyCornerRadius()
    }
}
