//
//  MagCategoryCell.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/5/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit

// Class MagCategoryCell: Responsible for handling specific functionality in the app.class MagCategoryCell: UICollectionViewCell {
    static let reuseIdentifier = "magCategory-cell-reuse-identifier"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: MyLabel!
    @IBOutlet weak var descriptionLabel: MyLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
        descriptionLabel.addLineSpacing(spaceLine: 4)
    }
}

extension MagCategoryCell {
// Function configure: Performs a specific task in the class.    func configure() {
        //
    }
}
