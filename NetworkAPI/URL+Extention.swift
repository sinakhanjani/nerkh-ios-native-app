//
//  URL+Extention.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/9/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import Foundation

extension URL {
    public func withQuries(_ queries:[String:Any]) -> URL? {
        var components = URLComponents.init(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap {
            URLQueryItem.init(name: $0.0, value: String(describing: $0.1))
        }
        return components?.url
    }
}
