//
//  Generic.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/20/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import Foundation

// MARK: - Generic
struct Generic<T: Codable>: Codable {
    let error: Bool
    let reason: String
    let data: T
}
