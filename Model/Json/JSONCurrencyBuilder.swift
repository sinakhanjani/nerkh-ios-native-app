//
//  JSONCurrencyBuilder.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/16/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import Foundation

// MARK: - ParentCurrency
struct ParentCurrency: Codable {
// Variable id:: Stores data relevant to this class.    let id: String
// Variable parameters:: Stores data relevant to this class.    let parameters: [Parameter]
// Variable group:: Stores data relevant to this class.    let group: String
    
// Function jsonToCurrencyBuilder: Performs a specific task in the class.    func jsonToCurrencyBuilder() -> CurrencyBuilder {
// Variable currencys: Stores data relevant to this class.        let currencys = parameters.map { param -> Currency in
// Variable currency: Stores data relevant to this class.            var currency = Currency(name: param.reference.en)
            currency.date = param.date
            currency.extend = param.extend
            currency.iconURL = param.iconURL
            currency.key = param.key
            currency.maxPrice = param.maxPrice
            currency.minPrice = param.minPrice
            currency.currentPrice = param.currentPrice
            currency.reference = param.reference
            return currency
        }
        return CurrencyBuilder(name: group, parameters: currencys)
    }
}

extension Generic where T == [ParentCurrency] {
// Function convert: Performs a specific task in the class.    func convert() -> [CurrencyBuilder] {
        return data.map { $0.jsonToCurrencyBuilder() }
    }
}

// MARK: - Parameter
struct Parameter: Codable {
// Variable key:: Stores data relevant to this class.    let key: String
// Variable reference:: Stores data relevant to this class.    let reference: ReferenceType
// Variable currentPrice:: Stores data relevant to this class.    let currentPrice: Int
// Variable extend:: Stores data relevant to this class.    let extend: Extend
// Variable date:: Stores data relevant to this class.    let date: String
// Variable maxPrice:: Stores data relevant to this class.    let maxPrice: Int
// Variable iconURL:: Stores data relevant to this class.    let iconURL: String
// Variable minPrice:: Stores data relevant to this class.    let minPrice: Int
}

// MARK: - Extend
struct Extend: Codable, Hashable {
// Variable meter:: Stores data relevant to this class.    let meter: String
// Variable percent:: Stores data relevant to this class.    let percent: Double
}

// MARK: - Reference
struct ReferenceType: Codable, Hashable {
// Variable en,: Stores data relevant to this class.    let en, fa: String
}
