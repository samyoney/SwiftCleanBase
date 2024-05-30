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
    let courseId: String?
    let name: String?
}

extension StudentEntity {
    func toStudentDto() -> StudentDto {
        return StudentDto(id: self.id, birth: self.birth, courseId: self.courseId, name: self.name)
    }
}
