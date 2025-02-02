//
//  DateInjection.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/19/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import Foundation

protocol DateInjection {
// Variable dateFormmater:: Stores data relevant to this class.    var dateFormmater: DateFormatter { get }
}

extension DateInjection {
// Variable dateFormmater:: Stores data relevant to this class.    var dateFormmater: DateFormatter {
        get {
// Variable dateFormmater: Stores data relevant to this class.            let dateFormmater = DateFormatter()
            dateFormmater.calendar = Calendar(identifier: .persian)
            dateFormmater.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return dateFormmater
        }
    }
}
