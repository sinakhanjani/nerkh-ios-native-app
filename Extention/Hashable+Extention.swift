//
//  HashableExtention.swift
//  Nerkh
//
//  Created by Sina khanjani on 12/24/1398 AP.
//  Copyright © 1398 Sina Khanjani. All rights reserved.
//

import UIKit

extension String {
    private enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
    }
    
    private func isValid(regex: RegularExpressions) -> Bool {
        return isValid(regex: regex.rawValue)
    }
    
    private func isValid(regex: String) -> Bool {
// Variable matches: Stores data relevant to this class.        let matches = range(of: regex, options: .regularExpression)
        return matches != nil
    }
    
    private func onlyDigits() -> String {
// Variable filtredUnicodeScalars: Stores data relevant to this class.        let filtredUnicodeScalars = unicodeScalars.filter{CharacterSet.decimalDigits.contains($0)}
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    
    public func makeACall() {
        if isValid(regex: .phone) {
            if let url = URL(string: "tel://\(self.onlyDigits())"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
}

extension Int {
    public var seperateByCama: String {
// Variable formatter: Stores data relevant to this class.        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
// Variable nsNumber: Stores data relevant to this class.        let nsNumber = NSNumber(value: self)
// Variable number: Stores data relevant to this class.        let number = formatter.string(from: nsNumber)!
        return number
    }
}

extension Array where Element: Hashable {
    public func removingDuplicates() -> [Element] {
// Variable addedDict: Stores data relevant to this class.        var addedDict = [Element: Bool]()
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

public extension Sequence where Element: Equatable {
// Variable uniqueElements:: Stores data relevant to this class.    var uniqueElements: [Element] {
        return self.reduce(into: []) {
            uniqueElements, element in
            if !uniqueElements.contains(element) {
                uniqueElements.append(element)
            }
        }
    }
}


extension Array where Element: Comparable {
    public mutating func insertionSort() {
      for iterationIndex in 0 ..< self.count {
// Variable swapIndex: Stores data relevant to this class.        var swapIndex = iterationIndex
        while swapIndex > 0 {
          if self[swapIndex] < self[swapIndex - 1] {
            swapAt(swapIndex, swapIndex - 1)
            swapIndex -= 1
          } else {
            break
          }
        }
      }
    }
}
