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
    var method: String { get }
    
    var headers: [String : String]? { get }
    
    var url: URL { get }
    
    func body() throws -> Data?
}

enum RestfulEndpoint {
    func body() throws -> Data? {
        return nil
    }
    
    var method: String{
        switch self {
        case .login: return "POST"
        case .register: return "POST"
        case .student: return "GET"
        case .course: return "GET"
        }
    }
    
    var headers: [String : String]? {
        return ["x-api-key": self.path]
    }
    
    var url: URL {
        return URL(string: self.path, relativeTo: baseURL)!
    }
    
    private var path: String {
        switch self {
        case .login: return "login/"
        case .register: return "register/"
        case .student: return "get/student/"
        case .course: return "get/course/"
        }
    }
    
    case login
    case register
    case student
    case course
}
