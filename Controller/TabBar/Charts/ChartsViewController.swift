//
//  ChartsViewController.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/5/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit

// Class ChartsViewController: Responsible for handling specific functionality in the app.class ChartsViewController: TabBarViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private var viewModel = ChartViewModel(title: "Chart")

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = viewModel.title
// Variable canallable: Stores data relevant to this class.        let canallable = viewModel.objectWillChange
         .sink { [unowned self = self] in
            print("oldValue: ",self.viewModel.title)
            DispatchQueue.main.async { [unowned self = self] in
                print("newValue: ",self.viewModel.title)
                self.titleLabel.text = self.viewModel.title
            }
         }
        viewModel.title = "apple"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func setupUI() {
        super.setupUI()
        navigationItem.title = "Chart"
    }
}
