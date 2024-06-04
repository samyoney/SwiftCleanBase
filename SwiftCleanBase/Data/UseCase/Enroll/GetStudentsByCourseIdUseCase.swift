//
//  GetStudentsByCourseIdUseCase.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import Resolver

class GetStudentsByCourseIdUseCase {
    
    @Injected private var courseRepository: CourseRepository
    
    func callAsFunction(courseId: String) async -> [StudentDto]? {
        await courseRepository.getEnrollCourse()?.first { entity in entity.id == courseId }?.student?.map { entity in
            entity.toStudentDto()
        }
    }
}
