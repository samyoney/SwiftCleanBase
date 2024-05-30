//
//  RestfulEndPoint.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/05/30.
//

import Foundation


#if DEBUG
    private let baseURL = URL(string: "https://rickandmortyapi.com/api/")
#else
    private let baseURL = URL(string: "https://rickandmortyapi.com/api/")
#endif

protocol Endpoint {
    var url: URL { get }
    var path: String { get }
}

enum RestfulEndpoint: Endpoint {

    var url: URL {
        return URL(string: self.path, relativeTo: baseURL)!
    }
    
    var path: String {
        switch self {
        case .characters(let page): return "character/?page=\(page)"
        case .character(let id): return "character/\(id)"
        case .locations: return "location"
        case .location(let id): return "location/\(id)"
        }
    }
    
    case characters(Int)
    case character(Int)
    case locations
    case location(Int)
}
