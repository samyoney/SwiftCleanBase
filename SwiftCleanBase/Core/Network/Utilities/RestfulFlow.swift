//
//  RestfulFlow.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/03.
//

import Foundation

enum RestfulFlow<T> {
    case failure(_ error: RestfulError)
    case success(_ data: T)
}
