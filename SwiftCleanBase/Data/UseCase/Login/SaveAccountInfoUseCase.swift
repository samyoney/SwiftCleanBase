//
//  SaveAccountInfoUseCase.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import Resolver

class SaveAccountInfoUseCase {
    
    @Injected private var repository: AccountRepository
    
    func callAsFunction(username: String, password: String) {
        repository.username = username
        repository.password = password
    }
}
