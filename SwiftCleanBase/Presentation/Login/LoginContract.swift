//
//  LoginState.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation

struct LoginState: Equatable {
    var username: String = String()
    var password: String = String()
    var name: String = String()
    var birth: String = String()
    var isRegisterScreen: Bool = false
    var loadingState: LoadingState<Nothing> = .idle
}

enum LoginEvent {
    case changeLoginMode
    case register
    case login
    case idleReturn
}
