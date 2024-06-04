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
    @Injected private var swiftData: SwiftDataManager
    
    private var cancellable: AnyCancellable?
    
    func fetchStudents(_ completion: @escaping (RestfulFlow<StudentResponse>) -> Void) {
        cancellable = studentService.fetch(completion)
    }
    
    func getStudent(id:String) async -> StudentEntity?  {
        await swiftData.getStudent(id: id)
    }
    
    func getListStudent() async -> [StudentEntity]? {
        await swiftData.getListStudent()
    }
    
    func updateStudent(studentEntity: StudentEntity) async {
        await swiftData.updateStudent(studentEntity: studentEntity)
    }
    
    func insertListStudent(studentEntities: [StudentEntity]) async {
        await swiftData.insertListStudent(studentEntities: studentEntities)
    }
    
    func suspend() {
        cancellable?.cancel()
    }
}
