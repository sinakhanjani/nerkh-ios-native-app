//
//  DataSource.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/19/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit

// Class CurrencyDataSource: Responsible for handling specific functionality in the app.class CurrencyDataSource: UICollectionViewDiffableDataSource<CurrencyBuilder, Currency> {

    public var filteredItems: [CurrencyBuilder] = []
    public var data: [CurrencyBuilder]
    
    init(data: [CurrencyBuilder], collectionView: UICollectionView) {
        self.data = data
        filteredItems = []
// Variable cellProvider: Stores data relevant to this class.        let cellProvider = { (_:UICollectionView,_:IndexPath,_:Currency) -> UICollectionViewCell? in
            return nil
        }
        super.init(collectionView: collectionView, cellProvider: cellProvider)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard !SearchControllerAdapter.isFiltering else {
            return filteredItems.count
        }
        return data.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard !SearchControllerAdapter.isFiltering else {
            return filteredItems[section].parameters.count
        }
        return data[section].parameters.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Get a cell of the desired kind.
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CurrencyCell.reuseIdentifier,
            for: indexPath) as? CurrencyCell else { fatalError("Cannot create new cell") }
// Variable currency:: Stores data relevant to this class.        var currency: Currency
        if SearchControllerAdapter.isFiltering {
            currency = filteredItems[indexPath.section].parameters[indexPath.item]
        } else {
            currency = data[indexPath.section].parameters[indexPath.item]
        }
        // Populate the cell with our item description.
        cell.titleLabel.text = currency.reference?.en
        cell.priceLabel.text = "\(currency.currentPrice!)"
        cell.dateLabel.text = dateFormmater.string(from: Date())
        // Return the cell.
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // Get a supplementary view of the desired kind.
// Variable headerFooter: Stores data relevant to this class.        let headerFooter = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: CurrencyResusableView.reuseIdentifier,
            for: indexPath) as! CurrencyResusableView
        // Populate the view with our section's description.
        // Return the view.
        return headerFooter
    }
}

extension CurrencyDataSource: DateInjection { }
extension CurrencyDataSource: CurrencyFetchComposite { }
