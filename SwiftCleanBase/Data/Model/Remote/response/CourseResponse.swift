//
//  CourseResponse.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/05/31.
//

import Foundation

struct CourseResponse: BaseResponse {
    let status: Int
    let message: String
    let course: [Course]
}

struct Course: Codable {
    let id: String
    let name: String
    let instructor: String
    let topics: [String]
}

