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
    var path: String { get }
    var method: RestfulMethod { get }
    var url: URL { get }
    
    var headers: [String : String]? { get }

    func body() throws -> Data?
}

enum RestfulEndpoint: Endpoint {
    func body() throws -> Data? {
    }
    
    var method: RestfulMethod{
        switch self {
        case .login(let request): return .post
        case .register(let request): return .post
        }
    }
    
    var headers: [String : String]? {
        return ["x-api-key": self.path]
    }
    
    var url: URL {
        return URL(string: self.path, relativeTo: baseURL)!
    }
    
    var path: String {
        switch self {
        case .login(let request): return "character/?page=\(request.username)"
        case .register(let request): return "character"
        }
    }
    
    case login(request: LoginRequest)
    case register(request: RegisterRequest)
}
