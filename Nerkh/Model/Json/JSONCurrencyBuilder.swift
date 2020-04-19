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
    let id: String
    let parameters: [Parameter]
    let group: String
    
    func jsonToCurrencyBuilder() -> CurrencyBuilder {
        let currencys = parameters.map { param -> Currency in
            var currency = Currency(name: param.reference.en)
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
    func convert() -> [CurrencyBuilder] {
        return data.map { $0.jsonToCurrencyBuilder() }
    }
}

// MARK: - Parameter
struct Parameter: Codable {
    let key: String
    let reference: ReferenceType
    let currentPrice: Int
    let extend: Extend
    let date: String
    let maxPrice: Int
    let iconURL: String
    let minPrice: Int
}

// MARK: - Extend
struct Extend: Codable, Hashable {
    let meter: String
    let percent: Double
}

// MARK: - Reference
struct ReferenceType: Codable, Hashable {
    let en, fa: String
}
