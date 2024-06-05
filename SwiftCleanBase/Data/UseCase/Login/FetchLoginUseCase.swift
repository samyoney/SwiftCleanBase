//
//  FetchLoginUseCase.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/03.
//

import Foundation
import Resolver

class FetchLoginUseCase {

    @Injected private var repository: AccountRepository

    func callAsFunction(username: String, password: String, _ failure: @escaping (_ error: RestfulError) -> Void, _ onNext: @escaping (_ res: LoginResponse) -> Void) {
        self.repository.login(username: username, password: password) {  flow in
            switch flow {
            case .failure(let error):
                failure(error)
            case .success(let data):
                onNext(data)
            }
        }
    }
}



