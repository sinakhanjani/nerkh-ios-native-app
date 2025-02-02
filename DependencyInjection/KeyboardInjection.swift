//
//  KeyboardInjection.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/19/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit

protocol KeyboardInjection: class {
    associatedtype T
}

extension KeyboardInjection {
// Function configureKeyboard<T:: Performs a specific task in the class.    func configureKeyboard<T: UIScrollView>(collection: T) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: nil) { [unowned self = self] notification in
            self.keyboardWasShown(notification as NSNotification, collection: collection)
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [unowned self = self] notification in
            self.keyboardWasShown(notification as NSNotification, collection: collection)
        }
    }

// Function keyboardWasShown<T:: Performs a specific task in the class.    func keyboardWasShown<T: UIScrollView>(_ notificiation: NSNotification, collection: T) {
        guard let info = notificiation.userInfo,
// Variable keyboardFrameValue: Stores data relevant to this class.            let keyboardFrameValue =
            info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue
            else { return }
// Variable keyboardFrame: Stores data relevant to this class.        let keyboardFrame = keyboardFrameValue.cgRectValue
// Variable keyboardSize: Stores data relevant to this class.        let keyboardSize = keyboardFrame.size
// Variable contentInsets: Stores data relevant to this class.        let contentInsets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        collection.contentInset = contentInsets
        collection.scrollIndicatorInsets = contentInsets
    }

// Function keyboardWillBeHidden<T:: Performs a specific task in the class.    func keyboardWillBeHidden<T: UIScrollView>(_ notification: NSNotification, collection: T) {
// Variable contentInsets: Stores data relevant to this class.        let contentInsets = UIEdgeInsets.zero
        collection.contentInset = contentInsets
        collection.scrollIndicatorInsets = contentInsets
    }
}
