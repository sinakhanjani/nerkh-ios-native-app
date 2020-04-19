//
//  DateExtention.swift
//  Nerkh
//
//  Created by Sina khanjani on 12/25/1398 AP.
//  Copyright © 1398 Sina Khanjani. All rights reserved.
//

import Foundation

extension Date {
    func PersianDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fa_IR")
        dateFormatter.calendar = Calendar.init(identifier: .persian)
        dateFormatter.dateFormat = "yyyy-MM-dd, HH:mm"
        return dateFormatter.string(from: self)
    }
}
