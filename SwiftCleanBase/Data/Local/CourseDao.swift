//
//  CourseDao.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/05.
//

import Foundation
import SwiftData
import Resolver

class CourseDao {
    
    @Injected private var mainContext: ModelContext
    
    func insertListCourse(courseEntities: [CourseEntity]) {
        courseEntities.forEach { courseEntity in
            mainContext.insert(courseEntity)
        }
    }
    
    func getListCourse() -> [CourseEntity]? {
        let descriptor = FetchDescriptor<CourseEntity>()
        let filteredList = try? mainContext.fetch(descriptor)
        return filteredList
    }
}
