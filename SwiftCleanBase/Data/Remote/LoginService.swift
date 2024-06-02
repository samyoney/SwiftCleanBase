//
//  LoginService.swift
//  SwiftCleanBase
//
//  Created by HS-Macbook on 2024/06/01.
//

import Foundation
import Resolver
import Combine

protocol LoginService {
    func fetch(param: LoginRequest) -> AnyPublisher<LoginResponse, Error>
}

class LoginServiceImpl {
    @Injected private var restfulClient: RestfulClient
    
    func fetch(param: LoginRequest) {
        let cancellable = restfulClient.post(RestfulEndpoint.login(request: param), using: requestBody)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Request completed successfully.")
                    case .failure(let error):
                        print("Request failed with error: \(error)")
                    }
                },
                receiveValue: {
                    // Handle the success, in this case it just returns Void, so no additional handling is needed.
                }
            )
    }
}


