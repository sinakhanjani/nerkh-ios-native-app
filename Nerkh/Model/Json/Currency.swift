//
//  Currency.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/5/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import Foundation

struct CurrencyBuilder: Codable, Hashable {
    var name: String
    var parameters: [Currency]
    var group: String = ""
    
    init(name: String, parameters: [Currency]) {
        self.name = name
        self.parameters = parameters
    }
    
    enum Category: Decodable {
      case today
      case week
      case month
      case year
    }
}

struct Currency: Codable, Hashable {
    var name: String
    var key: String?
    var currentPrice: Int?
    var extend: Extend?
    var date: String?
    var maxPrice: Int?
    var iconURL: String?
    var minPrice: Int?
    var reference: ReferenceType?
    
    init(name: String) {
        self.name = name
    }
}

extension CurrencyBuilder.Category: CaseIterable { }

extension CurrencyBuilder.Category: RawRepresentable {
  typealias RawValue = String
    
  var rawValue: RawValue {
    switch self {
    case .today: return "Today"
    case .week: return "Week"
    case .month: return "Month"
    case .year: return "Year"
    }
  }
    
  init?(rawValue: RawValue) {
    switch rawValue {
    case "Today": self = .today
    case "Week": self = .week
    case "Month": self = .month
    case "Year": self = .year
    default: return nil
    }
  }
}
