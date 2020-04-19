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
    let fcmToken, reference, name, id: String
    let tags: [Tag]
    let token: String
    let operationSystem: OperationSystem
    let mobile, auhtorizedType, family: String
    let authorized: Bool
}
