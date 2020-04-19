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
        func create<T : UIViewController> (type: T.Type) -> T  {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc : T = mainStoryboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
            
            return vc
        }
        return create(type: self)
    }
    
    public static func nav() -> UINavigationController {
        func create<T : UIViewController> (type: T.Type) -> T  {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc : T = mainStoryboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
            
            return vc
        }
        let nav = UINavigationController.create()
        let vc = create(type: self)
        nav.viewControllers.append(vc)
        return nav
    }
    
    static func create(withId id: String) -> UIViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: id)
        return vc
    }
}
