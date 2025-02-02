//
//  SearchControllerAdapter.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/20/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit

// Class SearchControllerAdapter: Responsible for handling specific functionality in the app.class SearchControllerAdapter {
    
    private static let searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    public static var isSearchBarEmpty: Bool {
        return searchController.searchBar.text!.isEmpty
    }
    
    public static var isFiltering: Bool {
// Variable searchBarScopeIsFiltering: Stores data relevant to this class.        let searchBarScopeIsFiltering =
          searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive &&
          (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    public static func configureSearchBar(completion: @escaping (_ searchController: UISearchController) -> Void) {
        searchController.automaticallyShowsScopeBar = true
        searchController.automaticallyShowsCancelButton = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search your currency ..."
        searchController.searchBar.searchTextField.textAlignment = .left
// Variable centeredParagraphStyle: Stores data relevant to this class.        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .right
        searchController.searchBar.searchTextField.font = UIFont.systemFont(ofSize: 14)
        searchController.searchBar.setValue("✕", forKey: "cancelButtonText")
        searchController.searchBar.scopeButtonTitles = CurrencyBuilder.Category.allCases
          .map { $0.rawValue }
        searchController.searchBar.setScopeBarButtonTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], for: .normal)
        completion(searchController)
    }
    
    public static func addToken(token text: String) {
        guard self.searchController.isActive else { return }
// Variable selectedToken: Stores data relevant to this class.        let selectedToken = UISearchToken(icon: UIImage(systemName: "tag"), text: text)
// Variable index: Stores data relevant to this class.        let index = searchController.searchBar.searchTextField.tokens.count
        searchController.searchBar.searchTextField.insertToken(selectedToken, at: index)
        searchController.searchBar.searchTextField.tokenBackgroundColor = .secondaryLabel
        searchController.searchBar.searchTextField.allowsCopyingTokens = true
        searchController.searchBar.searchTextField.allowsDeletingTokens = true
        searchController.searchBar.searchTextField.tokens.forEach { _ in
            // Do something with each search token.
        }
    }
}
