//
//  DatabaseManager.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/05/30.
//

import Foundation
import SwiftData

class SwiftDataManager {
    
    @MainActor
    private lazy var mainContext: ModelContext? = {
        let container = try? ModelContainer(
            for: CourseEntity.self, StudentEntity.self,
            configurations: .init()
        )
        return container?.mainContext
    }()
    
    func getStudent(id:String) async -> StudentEntity? {
        await MainActor.run {
            var descriptor = FetchDescriptor<StudentEntity>()
            descriptor.predicate = #Predicate { item in
                item.id != nil && id == item.id
            }
            let filteredList = try?  mainContext?.fetch(descriptor)
            return filteredList?.first
        }
    }
    
    func getListStudent() async -> [StudentEntity]? {
        await MainActor.run {
            let descriptor = FetchDescriptor<StudentEntity>()
            let filteredList = try? mainContext?.fetch(descriptor)
            return filteredList
        }
    }
    
    func updateStudent(studentEntity: StudentEntity) async {
        await MainActor.run {
            mainContext?.insert(studentEntity)
        }
    }
    
    func insertListStudent(studentEntities: [StudentEntity]) async {
        await MainActor.run {
            studentEntities.forEach { studentEntity in
                mainContext?.insert(studentEntity)
            }
        }
    }
    
    func insertListCourse(courseEntities: [CourseEntity]) async {
        await MainActor.run {
            courseEntities.forEach { courseEntity in
                mainContext?.insert(courseEntity)
            }
        }
    }
    
    func getListCourse() async -> [CourseEntity]? {
        await MainActor.run {
            let descriptor = FetchDescriptor<CourseEntity>()
            let filteredList = try? mainContext?.fetch(descriptor)
            return filteredList
        }
    }
}
