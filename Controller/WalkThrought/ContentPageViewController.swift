//
//  CarioContentPageViewController.swift
//  Cario
//
//  Created by Sinakhanjani on 8/1/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import AnimatedGradientView

// Class ContentPageViewController: Responsible for handling specific functionality in the app.class ContentPageViewController: BaseViewController {
    
    @IBOutlet weak var gradientView: AnimatedGradientView!
    
// Variable index: Stores data relevant to this class.    var index = 0
// Variable imageFile: Stores data relevant to this class.    var imageFile = ""
// Variable detail: Stores data relevant to this class.    var detail = ""
// Variable subject: Stores data relevant to this class.    var subject = ""
// Variable secendImage: Stores data relevant to this class.    var secendImage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: Action
    @IBAction func forwardButtonTapped(_ sender: UIButton) {
        switch index {
        case 0...1:
// Variable pageViewController: Stores data relevant to this class.            let pageViewController = parent as! WalkThroughViewController
            pageViewController.forward(index: index)
        case 2:
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        //
    }
    
    // Method
    private func updateUI() {
        // update outlets here.
        switch index {
        case 0...1:
            break
        case 2:
            break
        default:
            break
        }
        addGradientAnimateValues()
        endGradientAnimateValues()
    }
    
    private func addGradientAnimateValues() {
        gradientView.animationDuration = 4.0
        gradientView.animationValues = [
            (colors: ["000000","#121212"], .upLeft, .axial),
            (colors: ["#7E7E7E","#262626"], .upRight, .axial),
            (colors: ["000000", "#313131"], .upRight, .axial),
            (colors: ["#222222", "000000"], .upLeft, .axial),
            (colors: ["#000000", "000000"], .upRight, .axial),
        ]
    }
    
    private func endGradientAnimateValues() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+13.0) {
            UserDefaults.standard.set(true, forKey: "WalkThroughViewController")
            self.dismiss(animated: true, completion: nil)
        }
    }
}
