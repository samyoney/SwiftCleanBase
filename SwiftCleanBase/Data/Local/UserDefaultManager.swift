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
    
    func getValue<T>(key: String) -> T? {
        guard let value = userDefaults.value(forKey: key) else {
            return nil
        }
        if let typedValue = value as? T {
            return typedValue
        } else {
            return nil
        }
    }
    
    func setValue<T>(key: String, value: T) {
        self.userDefaults.set(value, forKey: key)
    }
}
