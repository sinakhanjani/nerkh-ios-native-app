//
//  Authentication.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/9/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import Foundation

public class Authentication {
    enum Platform: Int {
        case none,android,ios
    }
    
    static public let `default` = Authentication()

    private let defaults = UserDefaults.standard
    private var _isLoggedIn: Bool {
        get {
            return defaults.bool(forKey:"_isLoggedInKey")
        }
        set {
            defaults.set(newValue, forKey:"_isLoggedInKey")
        }
    }
    private var _token: String? {
        get {
            return defaults.value(forKey:"_tokenKey") as? String
        }
        set {
            defaults.set(newValue, forKey:"_tokenKey")
        }
    }
    
    // MARK: Access.
    public var isLoggedIn: Bool {
        return _isLoggedIn
    }
    public var token: String? {
        return _token
    }
    
    // MARK: Method.
    public func authenticationUser(token: String, isLoggedIn: Bool) {
        self._token = token
        self._isLoggedIn = isLoggedIn
    }
    
    public func logOutAuth() {
        self._isLoggedIn = false
        self._token = nil
    }
}
