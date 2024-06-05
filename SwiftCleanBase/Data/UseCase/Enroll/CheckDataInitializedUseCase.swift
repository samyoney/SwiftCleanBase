//
//  CheckDataInitializedUseCase.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import Resolver

class CheckDataInitializedUseCase {
    
    @Injected private var courseRepository: CourseRepository
    
    func callAsFunction() -> Bool {
        courseRepository.getEnrollCourse()?.isEmpty == false
    }
}
