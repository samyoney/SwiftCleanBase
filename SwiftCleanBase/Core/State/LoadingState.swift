//
//  LoadingState.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation

enum LoadingState<T>: Equatable {
    case idle
    case loading
    case loaded(_ data: T? = nil)
    case error(_ mess: String)

    var data: T? {
        switch self {
        case let .loaded(data): return data
        default: return nil
        }
    }
    
    static func == (lhs: LoadingState<T>, rhs: LoadingState<T>) -> Bool {
           switch (lhs, rhs) {
           case (.idle, .idle),
                (.loading, .loading), (.loaded, .loaded):
               return true
           case (let .error(mess1), let .error(mess2)):
               return mess1 == mess2
           default:
               return false
           }
       }
}
