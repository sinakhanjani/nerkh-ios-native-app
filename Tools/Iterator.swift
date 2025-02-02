//
//  Iterator.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/31/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import Foundation

public struct Queue<T> {
  private var array: [T?] = []

  private var head = 0
  
  public var isEmpty: Bool {
    return count == 0
  }
  
  public var count: Int {
    return array.count - head
  }
  
  public mutating func enqueue(_ element: T) {
    array.append(element)
  }
  
  public mutating func dequeue() -> T? {
    guard head < array.count,
// Variable element: Stores data relevant to this class.      let element = array[head] else {
        return nil
    }
    array[head] = nil
    head += 1
// Variable percentage: Stores data relevant to this class.    let percentage = Double(head)/Double(array.count)
    if array.count > 50,
      percentage > 0.25 {
        array.removeFirst(head)
        head = 0
    }
    return element
  }
}

extension Queue: Sequence {
  public func makeIterator()
    -> IndexingIterator<ArraySlice<T?>> {
// Variable nonEmptyValues: Stores data relevant to this class.    let nonEmptyValues = array[head ..< array.count]
    return nonEmptyValues.makeIterator()
  }
}
