//
//  Label.swift
//  Nerkh
//
//  Created by Sina khanjani on 12/15/1398 AP.
//  Copyright © 1398 Sina Khanjani. All rights reserved.
//

import UIKit

// Class MyLabel: Responsible for handling specific functionality in the app.class MyLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    @IBInspectable public var enText: String = ""
    @IBInspectable public var faText: String = ""
    
    private func setupUI() {
        configureReference()
    }
    
    private func configureReference() {
// Function setupLanguage: Performs a specific task in the class.        func setupLanguage() -> [String:Any] {
// Variable info: Stores data relevant to this class.            let info = ["enText":enText,
                        "faText":faText,
                        "alignment":textAlignment
                ] as [String : Any]
            return info
        }
        Reference.default.setupMultiLanguage(anyObject: self,setupReference: setupLanguage)
    }
}
