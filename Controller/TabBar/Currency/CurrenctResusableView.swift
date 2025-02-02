//
//  CurrenctResusableView.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/5/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit

// Class CurrencyResusableView: Responsible for handling specific functionality in the app.class CurrencyResusableView: UICollectionReusableView {
    static let reuseIdentifier = "currency-supplementary-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
