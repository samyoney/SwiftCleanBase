//
//  RestfulFlow.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/03.
//

import Foundation

enum RestfulFlow<T> {
    case failure(_ errorMsg: String)
    case success(_ data: T)
}
