//
//  AccountRepository.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/03.
//

import Foundation
import Resolver
import Combine

class AccountRepository {
    
    private let USERNAME_KEY = "USERNAME_KEY"
    private let PASSWORD_KEY = "PASSWORD_KEY"
    
    @Injected private var loginService: LoginService
    @Injected private var registerService: RegisterService
    @Injected private var userDefault: UserDefaultManager
    
    @Injected private var loginCancellable: AnyCancellable?
    @Injected private var registerCancellable: AnyCancellable?
    
    func login(username: String, password: String, _ completion: @escaping (RestfulFlow<LoginResponse>) -> Void) {
        loginCancellable = loginService.fetch(param: LoginRequest(username: username, password: password), completion)
    }
    
    func register(username: String, password: String, courseId: String, name: String, birth: String, _ completion: @escaping (RestfulFlow<LoginResponse>) -> Void) {
        registerCancellable = registerService.fetch(param: RegisterRequest(username: username, password: password, courseId: courseId, name: name, birth: birth), completion)
    }
    
    var username: String {
        get {
            userDefault.getValue(key: USERNAME_KEY) ?? String()
        }
        set {
            userDefault.setValue(key: USERNAME_KEY, value: newValue)
        }
    }
    
    var password: String {
        get {
            userDefault.getValue(key: PASSWORD_KEY) ?? String()
        }
        set {
            userDefault.setValue(key: PASSWORD_KEY, value: newValue)
        }
    }
    
    func suspend() {
        loginCancellable?.cancel()
        registerCancellable?.cancel()
    }
}
