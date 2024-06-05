//
//  FetchRegisterUseCase.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import Resolver

class FetchRegisterUseCase {
    
    @Injected private var repository: AccountRepository
    
    func callAsFunction(username: String, password: String, courseId: String, name: String, birth: String, _ failure: @escaping (_ error: RestfulError) -> Void, _ onNext: @escaping (_ res: RegisterResponse) -> Void) {
        self.repository.register(username: username, password: password, courseId: courseId, name: name, birth: birth) {  flow in
            switch flow {
            case .failure(let error):
                failure(error)
            case .success(let data):
                onNext(data)
            }
        }
    }
}
