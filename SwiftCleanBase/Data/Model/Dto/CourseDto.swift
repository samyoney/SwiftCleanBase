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

extension CourseEntity {
    func toCourseDto() -> CourseDto {
        return CourseDto(id: self.id, instructor: self.instructor, name: self.name, topics: self.topics)
    }
}
