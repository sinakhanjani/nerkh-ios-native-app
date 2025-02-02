//
//  ChartViewModel.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/29/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit

// Class ChartViewModel: Responsible for handling specific functionality in the app.class ChartViewModel: ObservableObject {
    
    @Published public var title: String
    
    init(title: String) {
        self.title = title
    }
}
