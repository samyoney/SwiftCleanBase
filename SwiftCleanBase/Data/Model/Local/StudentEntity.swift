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
    @Attribute var courseId: String?
    @Attribute var name: String?
    
    init(id: String?, birth: String?, courseId: String?, name: String?) {
        self.id = id
        self.birth = birth
        self.courseId = courseId
        self.name = name
    }

    convenience init(studentDto: StudentDto) {
        self.init(
            id: studentDto.id,
            birth: studentDto.birth,
            courseId: studentDto.courseId,
            name: studentDto.name
        )
    }
}
