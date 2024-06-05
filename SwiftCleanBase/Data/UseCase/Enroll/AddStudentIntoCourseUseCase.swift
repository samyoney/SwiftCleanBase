//
//  AddStudentIntoCourseUseCase.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import Resolver

class AddStudentIntoCourseUseCase {
    
    @Injected private var studentRepository: StudentRepository
    @Injected private var courseRepository: CourseRepository

    func callAsFunction(id: String, courseId: String) {
        if let student = studentRepository.getStudent(id: id) {
            student.course = courseRepository.getEnrollCourse()?.first { it in it.id == courseId }
            studentRepository.updateStudent(studentEntity: student)
        }
    }
}
