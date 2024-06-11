//
//  RestfulEndPoint.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/05/30.
//

import Foundation


#if DEBUG
private let baseURL = URL(string: "https://us-central1-samyoney.cloudfunctions.net/api/")
#else
private let baseURL = URL(string: "https://us-central1-samyoney.cloudfunctions.net/api/")
#endif

protocol Endpoint {
    var method: String { get }
    
    var headers: [String : String]? { get }
    
    var url: URL { get }
    
    func body() throws -> Data?
}

enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum RestfulEndpoint: Endpoint {
    func body() throws -> Data? {
        return nil
    }
    
    var method: String {
        _method.rawValue
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var url: URL {
        return URL(string: self._path, relativeTo: baseURL)!
    }
    
    private var _method: Method {
        switch self {
        case .login: return .post
        case .register: return .post
        case .student: return .get
        case .course: return .get
        }
    }
    
    private var _path: String {
        switch self {
        case .login: return "login"
        case .register: return "register"
        case .student: return "students"
        case .course: return "courses"
        }
    }
    
    case login
    case register
    case student
    case course
}
