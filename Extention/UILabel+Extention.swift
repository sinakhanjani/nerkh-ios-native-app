//
//  UILabelExtention.swift
//  Nerkh
//
//  Created by Sina khanjani on 12/23/1398 AP.
//  Copyright © 1398 Sina Khanjani. All rights reserved.
//

import UIKit

extension UILabel {
// Function highlight: Performs a specific task in the class.    func highlight(searchedText: String?, color: UIColor = .black) {
        guard let txtLabel = self.text?.lowercased(), let searchedText = searchedText?.lowercased() else {
            return
        }
// Variable attributeTxt: Stores data relevant to this class.        let attributeTxt = NSMutableAttributedString(string: txtLabel)
// Variable range:: Stores data relevant to this class.        let range: NSRange = attributeTxt.mutableString.range(of: searchedText, options: .caseInsensitive)
        attributeTxt.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        self.attributedText = attributeTxt
    }
    
// Function addLineSpacing: Performs a specific task in the class.    func addLineSpacing(spaceLine:CGFloat) {
// Variable attributedString: Stores data relevant to this class.        let attributedString =  NSMutableAttributedString(string: self.text!)
// Variable paragraphStyle: Stores data relevant to this class.        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spaceLine
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
}
