//
//  AppModule.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/01.
//

import Foundation
import Resolver
import SwiftData

extension Resolver: ResolverRegistering {
    @MainActor public static func registerAllServices() {
        defaultScope = .graph
        registerSingletons()
        registerRemote()
        registerDb()
        registerRepository()
        registerUseCase()
    }
    
    @MainActor private static func registerSingletons() {
        let mainContext = {
            let container = try? ModelContainer(
                for: CourseEntity.self, StudentEntity.self,
                configurations: .init()
            )
            return container?.mainContext
        }()
        register { mainContext }.scope(.application)
        register { RestfulClient() }.scope(.application)
        register { UserDefaultManager() }.scope(.application)
    }
    
    private static func registerRemote() {
        register { LoginServiceImpl() as LoginService }
        register { RegisterServiceImpl() as RegisterService }
        register { StudentServiceImpl() as StudentService }
        register { CourseServiceImpl() as CourseService }
    }
    
    private static func registerDb() {
        register { StudentDao() }
        register { CourseDao() }
    }

    private static func registerRepository() {
        register { AccountRepository() }
        register { CourseRepository() }
        register { StudentRepository() }
    }
    
    private static func registerUseCase() {
        register { FetchLoginUseCase() }
        register { CheckLoggedInUseCase() }
        register { FetchAutoLoginUseCase() }
        register { FetchRegisterUseCase() }
        register { SaveAccountInfoUseCase() }
        register { AddStudentIntoCourseUseCase() }
        register { CheckDataInitializedUseCase() }
        register { FetchCoursesUseCase() }
        register { FetchStudentsUseCase() }
        register { GetCoursesUseCase() }
        register { GetStudentsByCourseIdUseCase() }
        register { GetStudentsUseCase() }
        register { RemoveStudentFromCourseUseCase() }
        register { SaveCoursesUseCase() }
        register { SaveStudentsUseCase() }
    }
    
}
