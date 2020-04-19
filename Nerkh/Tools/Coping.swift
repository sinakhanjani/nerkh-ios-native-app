//
//  Coping.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/31/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import Foundation

public protocol Copying: class {

  init(_ prototype: Self)
}

extension Copying {
    
  public func copy() -> Self {
    return type(of: self).init(self)
  }
}

// MARK: - Prototype design pattern:
/*
public class Monster: Copying {

  public var health: Int
  public var level: Int

  public init(health: Int, level: Int) {
    self.health = health
    self.level = level
  }

  public required convenience init(_ monster: Monster) {
    self.init(health: monster.health, level: monster.level)
  }
}
*/
