//
//  LoginService.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/01.
//

import Foundation
import Resolver
import Combine

protocol LoginService {
    func fetch(param: LoginRequest, _ completion: @escaping (RestfulFlow<LoginResponse>) -> Void) -> AnyCancellable
}

class LoginServiceImpl: LoginService {
    @Injected private var restfulClient: RestfulClient
    
    func fetch(param: LoginRequest, _ completion: @escaping (RestfulFlow<LoginResponse>) -> Void) -> AnyCancellable {
        restfulClient.fetch(RestfulEndpoint.login, using: param)
            .observer { flow in
                completion(flow.map { result in
                    try result.parseJson()
                })
            }
    }
}


