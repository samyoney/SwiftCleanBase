//
//  RemoveStudentFromCourseUseCase.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import Resolver

class RemoveStudentFromCourseUseCase {
    
    @Injected private var studentRepository: StudentRepository
    
    func callAsFunction(id: String) async {
        if let student = await studentRepository.getStudent(id: id) {
            student.course = nil
            await studentRepository.updateStudent(studentEntity: student)
        }
    }
}
