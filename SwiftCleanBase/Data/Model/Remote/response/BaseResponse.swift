//
//  BaseResponse.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/05/31.
//

import Foundation

protocol BaseResponse: Codable {
    var status: Int { get }
    var message: String { get }
}
