//
//  FetchCoursesUseCase.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import Resolver

class FetchCoursesUseCase {
    
    @Injected private var courseRepository: CourseRepository
    
    func callAsFunction(_ failure: @escaping (_ error: RestfulError) -> Void, _ onNext: @escaping (_ res: CourseResponse) -> Void) {
        self.courseRepository.fetchCourses {  flow in
            switch flow {
            case .failure(let error):
                failure(error)
                break;
            case .success(let data):
                onNext(data)
                break;
            }
        }
    }
}
