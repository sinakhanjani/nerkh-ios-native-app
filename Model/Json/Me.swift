//
//  Me.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/9/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import Foundation

// MARK: - Me Builder design pattern.
protocol ProfileBuilderComposite { }

final class ProfileBuilder: ProfileBuilderComposite {
    public var profile: MeObject
    
    init(profile: MeObject) {
        self.profile = profile
    }
}

// MARK: - MeObject
struct MeObject: Codable {
// Variable fcmToken,: Stores data relevant to this class.    let fcmToken, reference, name, id: String
// Variable tags:: Stores data relevant to this class.    let tags: [Tag]
// Variable token:: Stores data relevant to this class.    let token: String
// Variable operationSystem:: Stores data relevant to this class.    let operationSystem: OperationSystem
// Variable mobile,: Stores data relevant to this class.    let mobile, auhtorizedType, family: String
// Variable authorized:: Stores data relevant to this class.    let authorized: Bool
}
