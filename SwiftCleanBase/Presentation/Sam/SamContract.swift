//
//  SamContract.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/10.
//

import Foundation

struct SamState {
    var listCourse: [CourseDto] = []
    var listStudent: [StudentDto] = []
    var listStudentByCode: [StudentDto] = []
    var isCourseScreen: Bool = true
}

enum SamEvent {
    case back
    case initData
    case removeStudent(_ id: String)
    case registerStudent(_ id: String)
    case selectCourse(_ id: String)
}
