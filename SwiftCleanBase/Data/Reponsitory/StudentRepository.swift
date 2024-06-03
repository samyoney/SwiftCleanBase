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
    
    @Injected private var cancellable: AnyCancellable?
    
    func fetchStudents(_ failure: @escaping (_ errorMsg: String) -> Void, _ onNext: @escaping (_ res: StudentResponse) -> Void) {
        cancellable = studentService.fetch { flow in
            switch flow {
            case .failure(let errorMsg):
                failure(errorMsg)
                break;
            case .success(let data):
                onNext(data)
                break;
            }
        }
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
