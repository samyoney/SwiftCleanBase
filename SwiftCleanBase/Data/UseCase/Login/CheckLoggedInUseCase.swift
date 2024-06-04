//
//  CheckLoggedInUseCase.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import Resolver

class CheckLoggedInUseCase {
    
    @Injected private var repository: AccountRepository
    
    func callAsFunction() -> Bool {
        repository.username.isEmpty || repository.password.isEmpty
    }
}
