//
//  RegisterRequest.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/01.
//

import Foundation

struct RegisterRequest : Encodable {
    let username: String
    let password: String
    let courseId: String
    let name: String
    let birth: String
}
