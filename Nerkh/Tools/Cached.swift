//
//  Cached.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/31/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import Foundation

@propertyWrapper
struct Cached<Input: Hashable, Output> {
    
    private var cachedFunction: (Input) -> Output

    init(wrappedValue: @escaping (Input) -> Output) {
        self.cachedFunction = Cached.addCachingLogic(to: wrappedValue)
    }

    /// Declare new type each time with @propertyWrapper, Use the case wrappedValue to declare for each time in code.
    var wrappedValue: (Input) -> Output {
        get { return self.cachedFunction }
        set { self.cachedFunction = Cached.addCachingLogic(to: newValue) }
    }
    
    private static func addCachingLogic(to function: @escaping (Input) -> Output) -> (Input) -> Output {
        var cache: [Input: Output] = [:]

        return { input in
            if let cachedOutput = cache[input] {
                return cachedOutput
            } else {
                let output = function(input)
                cache[input] = output
                return output
            }
        }
    }
}
