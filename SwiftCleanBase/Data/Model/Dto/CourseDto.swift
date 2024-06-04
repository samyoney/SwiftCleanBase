//
//  CourseDto.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/05/30.
//

import Foundation

struct CourseDto: Identifiable, Codable {
    let id: String?
    let instructor: String?
    let name: String?
    let topics: String?
}

extension CourseDto {
    func toCourseEntity() -> CourseEntity {
        return CourseEntity(id: self.id, name: self.name, instructor: self.instructor, topics: self.topics)
    }
}

extension CourseEntity {
    func toCourseDto() -> CourseDto {
        return CourseDto(id: self.id, instructor: self.instructor, name: self.name, topics: self.topics)
    }
}
