//
//  LaunchViewModel.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/10.
//

import Foundation
import Resolver

class LaunchViewModel: ViewModel {
    @Injected private var fetchAutoLoginUseCase: FetchAutoLoginUseCase
    @Injected private var fetchCoursesUseCase: FetchCoursesUseCase
    @Injected private var saveCoursesUseCase: SaveCoursesUseCase
    @Injected private var checkLoggedInUseCase: CheckLoggedInUseCase
    @Injected private var checkDataInitializedUseCase: CheckDataInitializedUseCase
    
    @Published var state: LoadingState<LanchState> = .idle
    
    func onTriggerEvent(_ eventType: LanchEvent) {
        switch eventType {
        case .initData:
            onInitializedData()
        }
    }
    
    private func onInitializedData() {
        if (checkDataInitializedUseCase()) {
            login()
        } else {
            fetchCoursesData()
        }
        
    }
    
    private func fetchCoursesData() {
        fetchCoursesUseCase({err in
            self.handleError(err.message)
        }, { res in
            if (res.status == 0) {
                self.saveCourses(res)
                self.login()
            } else {
                self.handleError(res.message)
            }
        })
    }
    
    private func saveCourses(_ res: CourseResponse) {
        saveCoursesUseCase(courses: res.courses)
    }
    
    func handleError(_ errorText: String) {
        state = .error(errorText)
    }
    
    private func login() {
        if (checkLoggedInUseCase()) {
            fetchAutoLoginUseCase({err in
            }, { res in
                if (res.status == 0) {
                    self.onNextScreen(isNextToSam: true)
                } else {
                    self.handleError(res.message)
                }
            })
        } else {
            onNextScreen(isNextToSam: false)
        }
    }
    
    private func onNextScreen(isNextToSam: Bool) {
        state = .loaded(.init(isNextToSam: isNextToSam))
    }
}
