//
//  DataBridgeManager.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/12.
//

import Foundation

class DataBridgeManager {
    public static let shared = DataBridgeManager()
    
    private var storage: [String: Any] = [:]

    func setValue<T>(_ value: T) {
        let key = String(describing: T.self)
        storage[key] = value
    }

    func getValue<T>() -> T? {
        let key = String(describing: T.self)
        let value = storage[key] as? T
        removeValue(T.self)
        return value
    }

    func removeValue<T>(_ type: T.Type) {
        let key = String(describing: T.self)
        storage.removeValue(forKey: key)
    }
}
