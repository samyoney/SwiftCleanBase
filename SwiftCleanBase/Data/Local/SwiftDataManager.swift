//
//  DatabaseManager.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/05/30.
//

import Foundation
import SwiftData

@MainActor
class SwiftDataManager {
    
    private lazy var mainContext: ModelContext? = {
        let container = try? ModelContainer(
            for: CourseEntity.self, StudentEntity.self,
            configurations: .init()
        )
        return container?.mainContext
    }()
         
    func getStudent(id:String) -> StudentEntity? {
        var descriptor = FetchDescriptor<StudentEntity>()
        descriptor.predicate = #Predicate { item in
            item.id != nil && id == item.id
        }
        let filteredList = try? mainContext?.fetch(descriptor)
        return filteredList?.first
    }
    
    func getListStudent() -> [StudentEntity]? {
        let descriptor = FetchDescriptor<StudentEntity>()
        let filteredList = try? mainContext?.fetch(descriptor)
        return filteredList
    }
    
    func updateStudent(studentEntity: StudentEntity) {
        mainContext?.insert(studentEntity)
    }
    
    func insertListStudent(studentEntities: [StudentEntity]) {
        studentEntities.forEach { studentEntity in
            mainContext?.insert(studentEntity)
        }
    }
    
    func insertListCourse(courseEntities: [CourseEntity]) {
        courseEntities.forEach { courseEntity in
            mainContext?.insert(courseEntity)
        }
    }
    
    func getListCourse() -> [CourseEntity]? {
        let descriptor = FetchDescriptor<CourseEntity>()
        let filteredList = try? mainContext?.fetch(descriptor)
        return filteredList
    }
}
