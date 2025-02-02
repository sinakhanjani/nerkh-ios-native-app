//
//  WalkThroughViewController.swift
//  Master
//
//  Created by Sinakhanjani on 4/17/1398 AP.
//  Copyright © 1398 iPersianDeveloper. All rights reserved.
//

import UIKit

// Class WalkThroughViewController: Responsible for handling specific functionality in the app.class WalkThroughViewController: UIPageViewController, UIPageViewControllerDataSource {

// Variable pageImages:: Stores data relevant to this class.    var pageImages: [String] = [""]
// Variable pageSubjects:: Stores data relevant to this class.    var pageSubjects: [String] = [""]
// Variable pageDetails:: Stores data relevant to this class.    var pageDetails: [String] = [""]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // Method
// Function updateUI: Performs a specific task in the class.    func updateUI() {
        dataSource = self
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
// Function pageViewController: Performs a specific task in the class.    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
// Variable index: Stores data relevant to this class.        var index = (viewController as! ContentPageViewController).index
        index -= 1
        return contentViewController(at: index)
    }
    
// Function pageViewController: Performs a specific task in the class.    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
// Variable index: Stores data relevant to this class.        var index = (viewController as! ContentPageViewController).index
        index += 1
        return contentViewController(at: index)
    }
    
// Function contentViewController: Performs a specific task in the class.    func contentViewController(at index: Int) -> ContentPageViewController? {
        if index < 0 || index >= self.pageSubjects.count {
            return nil
        }
// Variable pageContentViewController: Stores data relevant to this class.        let pageContentViewController = ContentPageViewController.create()
            pageContentViewController.index = index
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.subject = pageSubjects[index]
            pageContentViewController.detail = pageDetails[index]
        return pageContentViewController
    }
    
// Function forward: Performs a specific task in the class.    func forward(index: Int) {
        if let nextViewController = contentViewController(at: index + 1) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    static func wk() -> WalkThroughViewController {
// Variable mainStoryboard: Stores data relevant to this class.        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
// Variable vc: Stores data relevant to this class.        let vc = mainStoryboard.instantiateViewController(withIdentifier: String(describing: self)) as! WalkThroughViewController
    //    vc.modalTransitionStyle =
    //    vc.modalPresentationStyle =
        return vc
    }
}
