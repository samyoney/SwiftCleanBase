//
//  FetchAutoLoginUseCase.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import Resolver

class FetchAutoLoginUseCase {
        
    @Injected private var repository: AccountRepository

    func callAsFunction(_ failure: @escaping (_ error: RestfulError) -> Void, _ onNext: @escaping (_ res: LoginResponse) -> Void) {
        self.repository.login(username: repository.username, password: repository.password) {  flow in
            switch flow {
            case .failure(let error):
                failure(error)
                break;
            case .success(let data):
                onNext(data)
                break;
            }
        }
    }
}
