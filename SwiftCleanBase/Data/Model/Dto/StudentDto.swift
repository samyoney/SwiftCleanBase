//
//  StudentDto.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/05/30.
//

import Foundation

struct StudentDto: Identifiable, Codable {
    let id: String?
    let birth: String?
    let course: CourseDto?
    let name: String?
}
extension StudentDto {
    func toStudentEntity() -> StudentEntity {
        return StudentEntity(id: self.id, birth: self.birth, course: self.course?.toCourseEntity(), name: self.name)
    }
}

extension StudentEntity {
    func toStudentDto() -> StudentDto {
        return StudentDto(id: self.id, birth: self.birth, course: self.course?.toCourseDto(), name: self.name)
    }
}
