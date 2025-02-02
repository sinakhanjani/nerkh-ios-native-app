//
//  Currency.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/5/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import Foundation

struct CurrencyBuilder: Codable, Hashable {
// Variable name:: Stores data relevant to this class.    var name: String
// Variable parameters:: Stores data relevant to this class.    var parameters: [Currency]
// Variable group:: Stores data relevant to this class.    var group: String = ""
    
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
// Variable name:: Stores data relevant to this class.    var name: String
// Variable key:: Stores data relevant to this class.    var key: String?
// Variable currentPrice:: Stores data relevant to this class.    var currentPrice: Int?
// Variable extend:: Stores data relevant to this class.    var extend: Extend?
// Variable date:: Stores data relevant to this class.    var date: String?
// Variable maxPrice:: Stores data relevant to this class.    var maxPrice: Int?
// Variable iconURL:: Stores data relevant to this class.    var iconURL: String?
// Variable minPrice:: Stores data relevant to this class.    var minPrice: Int?
// Variable reference:: Stores data relevant to this class.    var reference: ReferenceType?
    
    init(name: String) {
        self.name = name
    }
}

extension CurrencyBuilder.Category: CaseIterable { }

extension CurrencyBuilder.Category: RawRepresentable {
  typealias RawValue = String
    
// Variable rawValue:: Stores data relevant to this class.  var rawValue: RawValue {
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
