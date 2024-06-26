//
//  SaveStudentsUseCase.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import Resolver

class SaveStudentsUseCase {
    
    @Injected private var studentRepository: StudentRepository
    
    func callAsFunction(students: [Student]) {
        let listStudentEntity = students.map { it in
            StudentEntity(name: it.name, birth: it.birth)
        }
        studentRepository.insertListStudent(studentEntities: listStudentEntity)
    }
}
