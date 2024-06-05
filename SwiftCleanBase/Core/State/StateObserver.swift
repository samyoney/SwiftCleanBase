//
//  StateObserver.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation

enum StateObserver<T> {

    case empty
    case idle(_ triggerData: T?)
    case loading
    case failed(_ mess: String)

    var triggerData: T? {
        switch self {
        case let .idle(triggerData): return triggerData
        default: return nil
        }
    }
    
    var error: String? {
        switch self {
        case let .failed(mess): return mess
        default: return nil
        }
    }
}
