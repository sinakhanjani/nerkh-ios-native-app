//
//  CurrencyFetchComposite.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/20/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit

protocol CurrencyFetchComposite {
// Variable data:: Stores data relevant to this class.    var data: [CurrencyBuilder] { get set }
// Variable filteredItems:: Stores data relevant to this class.    var filteredItems: [CurrencyBuilder] { get set }
    
    mutating func performQuery(with filter: String?, category: CurrencyBuilder.Category?)
    mutating func performQuery(data: Generic<[ParentCurrency]>)
}

extension CurrencyFetchComposite where Self: UICollectionViewDiffableDataSource<CurrencyBuilder,Currency> {
// Variable data:: Stores data relevant to this class.    var data: [CurrencyBuilder] {
        get {
            return []
        }
        set { }
    }
// Variable filteredItems:: Stores data relevant to this class.    var filteredItems: [CurrencyBuilder] {
        get {
            return []
        }
        set { }
    }
    
    mutating func performQuery(data: Generic<[ParentCurrency]>) {
        self.data = data.convert()
// Variable snapshot: Stores data relevant to this class.        var snapshot = NSDiffableDataSourceSnapshot<CurrencyBuilder, Currency>()
        self.data.forEach {
            snapshot.appendSections([$0])
            snapshot.appendItems($0.parameters)
        }
        if !SearchControllerAdapter.isFiltering {
            apply(snapshot, animatingDifferences: true)
        }
    }
    
    mutating func performQuery(with filter: String?, category: CurrencyBuilder.Category? = nil) {
// Variable sections: Stores data relevant to this class.        let sections = (filter == nil || filter == "") ? data : filteredItems(with: filter, category: category)
        self.filteredItems = sections
// Variable snapshot: Stores data relevant to this class.        var snapshot = NSDiffableDataSourceSnapshot<CurrencyBuilder, Currency>()
        sections.forEach {
            snapshot.appendSections([$0])
            snapshot.appendItems($0.parameters)
        }
      self.apply(snapshot, animatingDifferences: true)
    }
    
    private func filteredItems(with filter: String?, category: CurrencyBuilder.Category?) -> [CurrencyBuilder] {
// Function categoryMatch: Performs a specific task in the class.        func categoryMatch(_ category: CurrencyBuilder.Category?) -> Bool {
            guard let category = category else { return false }
            switch category {
            case .today:
                return true
            case .week:
                return false
            case .month:
                return false
            case .year:
                return true
            }
        }
// Variable currencies: Stores data relevant to this class.        var currencies = [CurrencyBuilder]()
            self.data.forEach { (currency) in
// Variable parameters: Stores data relevant to this class.            let parameters = currency.parameters.filter { (currency: Currency) -> Bool in
                return currency.name.lowercased().contains(filter!.lowercased()) && categoryMatch(category)
            }
            .sorted { $0.name < $1.name }
            if !parameters.isEmpty {
// Variable filteredCurrency: Stores data relevant to this class.                var filteredCurrency = currency
                filteredCurrency.parameters = parameters
                currencies.append(filteredCurrency)
            }
        }
        return currencies
    }
}
