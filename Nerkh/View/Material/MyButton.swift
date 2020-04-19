//
//  MyButton.swift
//  Nerkh
//
//  Created by Sina khanjani on 12/15/1398 AP.
//  Copyright © 1398 Sina Khanjani. All rights reserved.
//

import UIKit

class MyButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    @IBInspectable var enText: String = ""
    @IBInspectable var faText: String = ""
    
    private func setupUI() {
        configureReference()
    }
    
    private func configureReference() {
        func setupLanguage() -> [String:Any] {
            let info = ["enText":enText,
                        "faText":faText
                ] as [String : Any]
            return info
        }
        Reference.default.setupMultiLanguage(anyObject: self, setupReference: setupLanguage)
    }
}
