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
    
    func fetchCourses(_ failure: @escaping (_ errorMsg: String) -> Void, _ onNext: @escaping (_ res: CourseResponse) -> Void) {
        cancellable = courseService.fetch { flow in
            switch flow {
            case .failure(let errorMsg):
                failure(errorMsg)
                break;
            case .success(let data):
                onNext(data)
                break;
            }
        }
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
