//
//  LoadingState.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation

enum LoadingState<T>: Equatable, Identifiable where T: Equatable {
    var id: String {
           switch self {
           case .idle:
               return "idle"
           case .loading:
               return "loading"
           case .loaded(_):
               return "loaded_\(UUID().uuidString)"
           case .error(let msg):
               return "error_\(msg)"
           }
       }
    
    case idle
    case loading
    case loaded(_ data: T? = nil)
    case error(_ msg: String)
    

    var data: T? {
        switch self {
        case let .loaded(data): return data
        default: return nil
        }
    }
}
