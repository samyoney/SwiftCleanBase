//
//  SaveCoursesUseCase.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import Resolver

class SaveCoursesUseCase {
    
    @Injected private var courseRepository: CourseRepository
    
    func callAsFunction(courses: [Course]) async {
        let listCourseEntity = courses.map { it in
            CourseEntity(id: it.id, name: it.name, instructor:  it.instructor, topics: it.topics.joined(separator: ","))
        }
        await courseRepository.insertListCourse(courseEntities: listCourseEntity)
    }
}
