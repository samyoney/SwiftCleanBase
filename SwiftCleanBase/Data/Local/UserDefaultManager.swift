//
//  UserDefaultManager.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/05/30.
//

import Foundation

class UserDefaultManager {
    
    private lazy var userDefaults = {
        return UserDefaults.standard
    }()
    
    private let USERNAME_KEY = "USERNAME_KEY"
    private let PASSWORD_KEY = "PASSWORD_KEY"

    var username: String {
        get {
            guard let userID =  self.userDefaults.string(forKey: USERNAME_KEY) else {
                return String()
            }
            return userID
        }
        set {
            self.userDefaults.set(newValue, forKey: USERNAME_KEY)
        }
    }
    
    var password: String {
        get {
            guard let userID =  self.userDefaults.string(forKey: PASSWORD_KEY) else {
                return String()
            }
            return userID
        }
        set {
            self.userDefaults.set(newValue, forKey: PASSWORD_KEY)
        }
    }
}
