//
//  CourseEntity.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/05/30.
//
import SwiftData

@Model class CourseEntity {
    @Attribute(.unique) var id: String?
    @Attribute var name: String?
    @Attribute var instructor: String?
    @Attribute var topics: String?
    
    @Relationship(deleteRule: .noAction, inverse: \StudentEntity.course)
    var student: [StudentEntity]?
        
    init(id: String?, name: String?, instructor: String?, topics: String?) {
        self.id = id
        self.name = name
        self.instructor = instructor
        self.topics = topics
    }
    
    convenience init(courseDto: CourseDto) {
        self.init(
            id: courseDto.id,
            name: courseDto.name,
            instructor: courseDto.instructor,
            topics: courseDto.topics
        )
    }
}

