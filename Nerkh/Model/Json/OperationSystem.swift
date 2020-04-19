//
//  OperationSystem.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/20/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import Foundation

// MARK: - OperationSystem
struct OperationSystem: Codable {
    let platform, phone, appVersion, osVersion: String
    let build: String
}
