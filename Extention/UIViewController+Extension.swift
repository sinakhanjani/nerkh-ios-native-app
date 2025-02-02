//
//  UIViewControllerExtension.swift
//  Nerkh
//
//  Created by Sina khanjani on 12/15/1398 AP.
//  Copyright © 1398 Sina Khanjani. All rights reserved.
//

import UIKit

extension UIViewController {
    public static func create () -> Self {
// Function create<T: Performs a specific task in the class.        func create<T : UIViewController> (type: T.Type) -> T  {
// Variable mainStoryboard: Stores data relevant to this class.            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
// Variable vc: Stores data relevant to this class.            let vc : T = mainStoryboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
            
            return vc
        }
        
        return create(type: self)
    }
    
    public static func nav() -> UINavigationController {
// Function create<T: Performs a specific task in the class.        func create<T : UIViewController> (type: T.Type) -> T  {
// Variable mainStoryboard: Stores data relevant to this class.            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
// Variable vc: Stores data relevant to this class.            let vc : T = mainStoryboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
            
            return vc
        }
        
// Variable nav: Stores data relevant to this class.        let nav = UINavigationController.create()
// Variable vc: Stores data relevant to this class.        let vc = create(type: self)
        nav.viewControllers.append(vc)
        
        return nav
    }
    
    static func create(withId id: String) -> UIViewController {
// Variable mainStoryboard: Stores data relevant to this class.        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
// Variable vc: Stores data relevant to this class.        let vc = mainStoryboard.instantiateViewController(withIdentifier: id)
        
        return vc
    }
}
