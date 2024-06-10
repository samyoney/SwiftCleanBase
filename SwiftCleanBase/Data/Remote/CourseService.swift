//
//  CourseService.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/03.
//

import Foundation

import Foundation
import Resolver
import Combine

protocol CourseService {
    func fetch(_ completion: @escaping (RestfulFlow<CourseResponse>) -> Void) -> AnyCancellable
}

class CourseServiceImpl: CourseService {
    @Injected private var restfulClient: RestfulClient
    
    func fetch(_ completion: @escaping (RestfulFlow<CourseResponse>) -> Void) -> AnyCancellable {
        restfulClient.fetch(RestfulEndpoint.course, using: Nothing())
            .observer { flow in
                completion(flow.map { result in
                    try result.parseJson()
                })
            }
    }
}
