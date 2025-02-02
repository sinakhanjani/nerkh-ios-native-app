//
//  UIFontExtension.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/5/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit

extension UIFont {
    static func yekanFontRegular(_ size: CGFloat) -> UIFont {
        return UIFont(name: "IRANYekanMobile-Light", size: size)!
    }
    
    static func yekanFontMedium(_ size: CGFloat) -> UIFont {
        return UIFont(name: "IRANYekanMobile-Medium", size: size)!
    }
    
    static func yekanFontBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "IRANYekanMobile-Bold", size: size)!
    }
}
