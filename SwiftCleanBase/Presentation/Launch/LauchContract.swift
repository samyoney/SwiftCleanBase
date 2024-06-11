//
//  LauchContract.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/10.
//

import Foundation

struct LanchState: Equatable {
    var isNextToSam: Bool = false
}

enum LanchEvent {
    case initData
}
