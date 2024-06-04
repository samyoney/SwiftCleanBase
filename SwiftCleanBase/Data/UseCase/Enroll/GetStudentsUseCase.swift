//
//  GetStudentsUseCase.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import Resolver

class GetStudentsUseCase {
    
    @Injected private var studentRepository: StudentRepository
    
    func callAsFunction(courseId: String) async -> [StudentDto]? {
        await studentRepository.getListStudent()?.map { entity in
            entity.toStudentDto()
        }
    }
}
