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
    
    func callAsFunction(students: [Student]) async {
        let listStudentEntity = students.map { it in
            StudentEntity(name: it.name, birth: it.birth)
        }
        await studentRepository.insertListStudent(studentEntities: listStudentEntity)
    }
}
