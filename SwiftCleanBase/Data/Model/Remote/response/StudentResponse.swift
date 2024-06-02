//
//  StudentResponse.swift
//  SwiftCleanBase
//
//  Created by HS-Macbook on 2024/05/31.
//

import Foundation


struct StudentResponse: BaseResponse {
    let status: Int
    let message: String
    let students: [Student]
}

struct Student: Codable {
    let id: String
    let name: String
    let birth: String
}
