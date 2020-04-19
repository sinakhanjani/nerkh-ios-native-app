//
//  Cell+Extention.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/27/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    // The @objc is added to silence the complier errors
    @objc class var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell {
    // The @objc is added to silence the complier errors
    @objc class var identifier: String {
        return String(describing: self)
    }
}
