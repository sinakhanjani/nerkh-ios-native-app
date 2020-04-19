//
//  T.swift
//  Nerkh
//
//  Created by Sina khanjani on 12/15/1398 AP.
//  Copyright © 1398 Sina Khanjani. All rights reserved.
//

import UIKit

@propertyWrapper
struct ReferenceCached<Input: UIView, Output> {
    
    private var cachedFunction: (Input,() -> (NSTextAlignment,String)) -> Output

    init(wrappedValue: @escaping (Input,() -> (NSTextAlignment,String)) -> Output) {
        self.cachedFunction = wrappedValue
    }

    var wrappedValue: (Input,() -> (NSTextAlignment,String)) -> Output {
        get { return self.cachedFunction }
    }
}

public class Reference {
    
    static let `default` = Reference(type: .en)
        
    enum `Type` {
        case fa,en
    }
    
    private(set) var type = Type.en {
        didSet {
            NotificationCenter.default.post(name: didChangedReference, object: nil)
        }
    }

    public let didChangedReference = Notification.Name("didChangedReference")
    
    init(type: Type) {
        self.type = type
    }
    
    public func changedReferenceType() {
        self.type = (type == .en) ? .fa:.en
     }
        
    func setupMultiLanguage<T : AnyObject>(anyObject: T, setupReference: () -> [String:Any]) {
        let info = setupReference
        func setupInfo() -> (alignment: NSTextAlignment, text: String) {
            var attribute = (alignment: NSTextAlignment.center, text: "")
            if self.type == .en {
                if let enText = info()["enText"] as? String {
                    attribute.text = enText
                }
            } else {
                if let faText = info()["faText"] as? String {
                    attribute.text = faText
                }
            }
            if let alignment = info()["alignment"] as? NSTextAlignment {
                attribute.alignment = alignment

            }
            return attribute
        }
        switch anyObject {
        case is UIButton :
            // MARK: - Option 1: use with propertyWrapper pattern
            let value = { (button: UIButton, setupInfo: () -> (alignment: NSTextAlignment, text: String)) in
                button.setTitle(setupInfo().text, for: .normal)
                button.setTitle(setupInfo().text, for: .highlighted)
                button.setTitle(setupInfo().text, for: .selected)
            }
            let cached = ReferenceCached(wrappedValue: value)
            cached.wrappedValue(anyObject as! UIButton, setupInfo)
        case is UILabel:
            // MARK: - Option 2: use with generic pattern
            setupLabel(label: anyObject as! UILabel, setupInfo: setupInfo)
        default:
            break
        }
    }
    
    private func setupLabel(label: UILabel, setupInfo: () -> (alignment: NSTextAlignment, text: String)) {
        if setupInfo().alignment == .center {
            // do nothing
        } else {
            let alignment = type == .fa ? NSTextAlignment.right:NSTextAlignment.left
            label.textAlignment = alignment
        }
        label.text = setupInfo().text
    }
}




