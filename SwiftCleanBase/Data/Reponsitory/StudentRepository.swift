//
//  StudentRepository.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/03.
//

import Foundation
import Resolver
import Combine

class StudentRepository {
    
    @Injected private var studentService: StudentService
    @Injected private var studentDao: StudentDao
    
    private var cancellable: AnyCancellable?
    
    func fetchStudents(_ completion: @escaping (RestfulFlow<StudentResponse>) -> Void) {
        cancellable = studentService.fetch(completion)
    }
    
    func getStudent(id:String) -> StudentEntity?  {
        studentDao.getStudent(id: id)
    }
    
    func getListStudent() -> [StudentEntity]? {
        studentDao.getListStudent()
    }
    
    func updateStudent(studentEntity: StudentEntity) {
        studentDao.updateStudent(studentEntity: studentEntity)
    }
    
    func insertListStudent(studentEntities: [StudentEntity]) {
        studentDao.insertListStudent(studentEntities: studentEntities)
    }
    
    func suspend() {
        cancellable?.cancel()
    }
}
