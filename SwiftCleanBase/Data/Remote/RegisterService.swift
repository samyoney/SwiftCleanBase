//
//  RegisterService.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/03.
//

import Foundation
import Resolver
import Combine

protocol RegisterService {
    func fetch(param: RegisterRequest, _ completion: @escaping (RestfulFlow<RegisterResponse>) -> Void) -> AnyCancellable
}

class RegisterServiceImpl: RegisterService {
    @Injected private var restfulClient: RestfulClient
    
    func fetch(param: RegisterRequest, _ completion: @escaping (RestfulFlow<RegisterResponse>) -> Void) -> AnyCancellable {
        restfulClient.fetch(RestfulEndpoint.register, using: param)
            .observer { flow in
                completion(flow.map { result in
                    try result.parseJson()
                })
            }
    }
}


