//
//  KeychainManager.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/12.
//

import Foundation

class KeychainManager {
    
    private var accessToken = String()
    
    private static let shared = KeychainManager()

    func deleteToken() throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: accessToken
        ] as CFDictionary

        let status = SecItemDelete(query)

        guard status == errSecSuccess else {
            throw convertError(status)
        }
    }

    func saveToken(_ token: String) throws {
        guard let data = token.data(using: .utf8) else {
            throw KeychainError.invalidData
        }

        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecValueData: data,
            kSecAttrAccount: accessToken
        ] as CFDictionary

        let status = SecItemAdd(query, nil)

        guard status == errSecSuccess else {
            throw convertError(status)
        }
    }

    func updateToken(_ newToken: String) throws {
        guard let data = newToken.data(using: .utf8) else { return }

        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: accessToken
        ] as CFDictionary
        let attributesToUpdate = [kSecValueData: data] as CFDictionary

        let status = SecItemUpdate(query, attributesToUpdate)

        guard status == errSecSuccess else {
            throw convertError(status)
        }
    }

    func retrieveToken() throws -> String {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: accessToken,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: kCFBooleanTrue as Any
        ] as CFDictionary

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)

        guard status == errSecSuccess else {
            throw convertError(status)
        }

        guard let data = result as? Data else {
            throw KeychainError.invalidData
        }

        let token = String(decoding: data, as: UTF8.self)
        return token
    }
}

extension KeychainManager {
    private enum KeychainError: LocalizedError {
        case invalidData
        case itemNotFound
        case duplicateItem
        case incorrectAttributeForClass
        case unexpectedStatus(OSStatus)

        var message: String? {
            switch self {
            case .invalidData:
                return "Invalid data"
            case .itemNotFound:
                return "Item not found"
            case .duplicateItem:
                return "Duplicate Item"
            case .incorrectAttributeForClass:
                return "Incorrect Attribute for Class"
            case .unexpectedStatus(let status):
                return "Unexpected error - \(status)"
            }
        }
    }
    
    private func convertError(_ status: OSStatus) -> KeychainError {
        switch status {
        case errSecItemNotFound:
            return .itemNotFound
        case errSecDataTooLarge:
            return .invalidData
        case errSecDuplicateItem:
            return .duplicateItem
        default:
            return .unexpectedStatus(status)
        }
    }
}
