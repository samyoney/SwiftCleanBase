//
//  GetCoursesUseCase.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import Resolver

class GetCoursesUseCase {
    
    @Injected private var courseRepository: CourseRepository
    
    func callAsFunction() async -> [CourseDto]? {
        await courseRepository.getEnrollCourse()?.map { entity in
            entity.toCourseDto()
        }
    }
}
