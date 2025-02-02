//
//  MainViewController.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/4/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit
import SkeletonView
import NetworkAPI

// Class CurrencyViewController: Responsible for handling specific functionality in the app.class CurrencyViewController: TabBarViewController {
    
    static let sectionHeaderElementKind = "section-header-element-kind"
    
    private var viewModel: CurrencyViewModel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CurrencyViewModel(view: view)
        configureSearchController()
        socketConnection()
    }

    override func setupUI() {
        super.setupUI()
        navigationItem.title = "Stock"
    }
}

extension CurrencyViewController: UISearchResultsUpdating, UISearchBarDelegate {
    private func configureSearchController() {
        SearchControllerAdapter.configureSearchBar { [unowned self = self] (searchController) in
            self.navigationItem.searchController = searchController
            self.navigationItem.searchController!.searchResultsUpdater = self
            self.navigationItem.searchController!.searchBar.delegate = self
            self.definesPresentationContext = true
        }
    }
    
// Function updateSearchResults: Performs a specific task in the class.    func updateSearchResults(for searchController: UISearchController) {
// Variable searchBar: Stores data relevant to this class.        let searchBar = searchController.searchBar
// Variable category: Stores data relevant to this class.        let category = CurrencyBuilder.Category(rawValue:
        searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
        viewModel.dataSource.performQuery(with: searchBar.text, category: category)
    }
    
// Function searchBar: Performs a specific task in the class.    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
// Variable category: Stores data relevant to this class.        let category = CurrencyBuilder.Category(rawValue: searchBar.scopeButtonTitles![selectedScope])
        viewModel.dataSource.performQuery(with: searchBar.text, category: category)
    }
}

extension CurrencyViewController {
    // MARK: Websocket
    private func socketConnection() {
        WebSocket.default.websocketEcho()
        WebSocket.default.nerkhsocket(completion: { [unowned self = self] data in
// Variable jsonDecoder: Stores data relevant to this class.            let jsonDecoder = JSONDecoder()
            guard let data = try? jsonDecoder.decode(Generic<[ParentCurrency]>.self, from: data) else { return }
            DispatchQueue.main.async {
                self.viewModel.dataSource.performQuery(data: data)
            }
        })
    }
}
