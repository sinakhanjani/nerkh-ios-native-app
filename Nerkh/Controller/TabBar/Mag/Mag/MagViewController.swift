//
//  MagViewController.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/9/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit

class MagViewController: UIViewController {

    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    
    private let headerViewMaxHeight: CGFloat = 250
    private var headerViewMinHeight: CGFloat {
        return 44 + (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - UIScrollViewDelegate
extension MagViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = scrollView.contentOffset.y
        let newHeaderViewHeight: CGFloat = headerViewHeightConstraint.constant - y
        if newHeaderViewHeight > headerViewMaxHeight {
            headerViewHeightConstraint.constant = headerViewMaxHeight
        } else if newHeaderViewHeight < headerViewMinHeight {
            headerViewHeightConstraint.constant = headerViewMinHeight
        } else {
            headerViewHeightConstraint.constant = newHeaderViewHeight
            scrollView.contentOffset.y = 0
        }
        print(scrollView.contentOffset.y)
    }
}
