//
//  CourseRepository.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/03.
//

import Foundation
import Resolver
import Combine

class CourseRepository {
    
    @Injected private var courseService: CourseService
    @Injected private var swiftData: SwiftDataManager
    
    private var cancellable: AnyCancellable?
    
    func fetchCourses(_ completion: @escaping (RestfulFlow<CourseResponse>) -> Void) {
        cancellable = courseService.fetch(completion)
    }
    
    func insertListCourse(courseEntities: [CourseEntity]) async {
        await swiftData.insertListCourse(courseEntities: courseEntities)
    }
    
    func getEnrollCourse() async -> [CourseEntity]? {
        await swiftData.getListCourse()
    }
    
    func suspend() {
        cancellable?.cancel()
    }
}
