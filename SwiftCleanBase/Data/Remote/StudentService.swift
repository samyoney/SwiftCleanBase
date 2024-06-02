//
//  StudentService.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/03.
//

import Foundation
import Resolver
import Combine

protocol StudentService {
    func fetch(param: LoginRequest, _ completion: @escaping (RestfulFlow<StudentResponse>) -> Void) -> AnyCancellable
}

class StudentServiceImpl: StudentService {
    @Injected private var restfulClient: RestfulClient
    
    func fetch(param: LoginRequest, _ completion: @escaping (RestfulFlow<StudentResponse>) -> Void) -> AnyCancellable {
        restfulClient.fetch(RestfulEndpoint.student, using: param)
            .observer { flow in
                completion(flow.map { result in
                    try result.parseJson()
                })
            }
    }
}
