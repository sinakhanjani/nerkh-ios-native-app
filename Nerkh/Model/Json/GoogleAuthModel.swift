//
//  GoogleAuthModel.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/23/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import Foundation

// MARK: - GoogleAuth - Response
struct GoogleAuthResponse: Codable {
    let userID, token, username: String
}
