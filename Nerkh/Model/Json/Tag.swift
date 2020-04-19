//
//  Tag.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/20/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import Foundation

// MARK: - Tag
struct Tag: Codable {
    let id, subType, tagDescription, title: String
    let type, iconURL: String

    enum CodingKeys: String, CodingKey {
        case id, subType
        case tagDescription = "description"
        case title, type, iconURL
    }
}
