//
//  AppModule.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/01.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        defaultScope = .graph
        registerSingletons()
        registerRemote()
        registerRepository()
        registerUseCase()
    }
    
    private static func registerSingletons() {
        register { RestfulClient() }.scope(.application)
        register { SwiftDataManager() }.scope(.application)
        register { UserDefaultManager() }.scope(.application)
    }
    
    private static func registerRemote() {
        register { LoginServiceImpl() as LoginService }
        register { RegisterServiceImpl() as RegisterService }
        register { StudentServiceImpl() as StudentService }
        register { CourseServiceImpl() as CourseService }
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
