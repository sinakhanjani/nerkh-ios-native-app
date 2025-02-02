//
//  UIViewExtension.swift
//  Nerkh
//
//  Created by Sina khanjani on 12/15/1398 AP.
//  Copyright © 1398 Sina Khanjani. All rights reserved.
//

import UIKit

extension UIView {
// Function cornerRadius: Performs a specific task in the class.    func cornerRadius(corners: UIRectCorner, radius: CGFloat) {
        layoutIfNeeded()
// Variable path: Stores data relevant to this class.        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
// Variable mask: Stores data relevant to this class.         let mask = CAShapeLayer()
         mask.path = path.cgPath
        layer.mask = mask
    }
    
    public func dismissedKeyboardByTouch() {
// Variable touch: Stores data relevant to this class.        let touch = UITapGestureRecognizer(target: self, action: #selector(removeKeyboard(_:)))
        addGestureRecognizer(touch)
    }
    @objc private func removeKeyboard(_ gesture: UITapGestureRecognizer) {
        endEditing(true)
    }
    
// Function bindToKeyboard: Performs a specific task in the class.    func bindToKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(UIView.keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    @objc private func keyboardWillChange(_ notification: NSNotification) {
// Variable duration: Stores data relevant to this class.        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
// Variable curve: Stores data relevant to this class.        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
// Variable curFrame: Stores data relevant to this class.        let curFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
// Variable targetFrame: Stores data relevant to this class.        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
// Variable deltaY: Stores data relevant to this class.        let deltaY = targetFrame.origin.y - curFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
            
        },completion: {(true) in
            self.layoutIfNeeded()
        })
    }
}


extension UIView {
    public func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
// Variable renderer: Stores data relevant to this class.            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
// Variable image: Stores data relevant to this class.            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
}

extension CALayer {
    public func makeSnapshot() -> UIImage? {
// Variable scale: Stores data relevant to this class.        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(frame.size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        render(in: context)
// Variable screenshot: Stores data relevant to this class.        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        return screenshot
    }
}

extension UIView {
    public func makeSnapshot() -> UIImage? {
        if #available(iOS 10.0, *) {
// Variable renderer: Stores data relevant to this class.            let renderer = UIGraphicsImageRenderer(size: frame.size)
            return renderer.image { _ in drawHierarchy(in: bounds, afterScreenUpdates: true) }
        } else {
            return layer.makeSnapshot()
        }
    }
}
