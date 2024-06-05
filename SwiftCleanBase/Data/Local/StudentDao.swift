//
//  StudentDao.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/05.
//

import Foundation
import Resolver
import SwiftData

class StudentDao {
    
    @Injected private var mainContext: ModelContext
    
    func getStudent(id:String) -> StudentEntity? {
        var descriptor = FetchDescriptor<StudentEntity>()
        descriptor.predicate = #Predicate { item in
            item.id != nil && id == item.id
        }
        let filteredList = try?  mainContext.fetch(descriptor)
        return filteredList?.first
    }
    
    func getListStudent() -> [StudentEntity]? {
        let descriptor = FetchDescriptor<StudentEntity>()
        let filteredList = try? mainContext.fetch(descriptor)
        return filteredList
    }
    
    func updateStudent(studentEntity: StudentEntity) {
        mainContext.insert(studentEntity)
    }
    
    func insertListStudent(studentEntities: [StudentEntity]) {
        studentEntities.forEach { studentEntity in
            mainContext.insert(studentEntity)
        }
    }

}
