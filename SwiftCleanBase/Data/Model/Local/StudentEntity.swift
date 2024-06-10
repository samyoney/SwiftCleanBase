//
//  StudentEntity.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/05/30.
//
import Foundation
import SwiftData

@Model class StudentEntity {
    @Attribute(.unique) var id: String?
    @Attribute var birth: String?
    @Attribute var name: String?
    
    @Relationship var course: CourseEntity?

    init(id: String?, birth: String?, course: CourseEntity?, name: String?) {
        self.id = id ?? UUID().uuidString
        self.birth = birth
        self.course = course
        self.name = name
    }
    
    init(name: String?, birth: String?) {
        self.id = UUID().uuidString
        self.name = name
        self.birth = birth
    }


    convenience init(studentDto: StudentDto) {
        self.init(
            id: studentDto.id,
            birth: studentDto.birth,
            course: studentDto.course?.toCourseEntity(),
            name: studentDto.name
        )
    }
}
