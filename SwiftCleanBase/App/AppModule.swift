//
//  AppModule.swift
//  SwiftCleanBase
//
//  Created by HS-Macbook on 2024/06/01.
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
        register { RestfulClient()  }.scope(.application)
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
        // register { CheckLoggedInUseCase() }
    }
    
}
