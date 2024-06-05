//
//  LoginViewModel.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import Resolver

@MainActor
class LoginViewModel: ObservableObject {
    @Injected private var fetchRegisterUseCase: FetchRegisterUseCase
    @Injected private var fetchLoginUseCase: FetchLoginUseCase
    @Injected private var fetchStudentsUseCase: FetchStudentsUseCase
    @Injected private var saveStudentsUseCase: SaveStudentsUseCase
    @Injected private var saveAccountInfoUseCase: SaveAccountInfoUseCase
    
    @Published var username: String = "sfasfasfsafsaf"
    @Published var password: String = "sàafsafasasf"
    @Published var name: String = String()
    @Published var birth: String = String()
    @Published var isRegisterScreen = false
    @Published var isShowingError = false
    
    @Published private var stateObserver: StateObserver<LoginEvent> = .empty
    
    func onChangeMode() {
        isRegisterScreen = !isRegisterScreen
    }
    
    func onLogin() {
        if !checkValidation(username: username, password: password) {
            handleError(errorText: R.string.textFile.validationFailText())
            return
        }
        fetchLoginUseCase(username: username, password: password, { error in
            self.handleError(errorText: error.message)
        }, { res in
            if (res.status == 0) {
                self.handleAfterLogin(username: self.username, password: self.password)
            } else {
                self.handleError(errorText: R.string.textFile.errorApiMessage())
            }
        })
    }
    
    private func handleAfterLogin(username: String, password: String) {
        fetchStudentsData  { res in
            self.saveStudents(res: res)
            self.saveAccountInfo(username: username, password: password)
            self.stateObserver = .idle(LoginEvent(isNextScreen: true))
        }
    }
    
    func onRegister() {
        
    }
    
    private func fetchStudentsData(onFinish: (_ res: StudentResponse) -> Void) {    
        
    }
    
    private func saveAccountInfo(username: String, password: String) {
        saveAccountInfoUseCase(username: username, password: password)
    }
    
    private func saveStudents(res: StudentResponse) {
        saveStudentsUseCase(students: res.students)
    }
    
    func onInputBirth(year: Int, month: Int) {
        birth = "\(year)/\(month)"
    }
    
    func onInputName(text: String) {
        username = text
    }
    
    func onInputPassword(text: String) {
        if (text.isEmpty || (text.range(of: "^[A-Z0-9a-z]+$", options: .regularExpression) != nil) && text.count <= 16) {
            username = text.uppercased(with: Locale(identifier: "en_US"))
        }
    }
    
    func onInputUsername(text: String) {
        if (text.isEmpty || (text.range(of: "^[A-Z0-9a-z]+$", options: .regularExpression) != nil) && text.count <= 16) {
            username = text.uppercased(with: Locale(identifier: "en_US"))
        }
    }
    
    private func checkValidation(username: String? = nil, password: String? = nil, birthday: String? = nil) -> Bool {
        let isCompanyIDValid = username != nil
        let isUserValid = password != nil
        let isBirthdayValid = birthday == nil || !birthday!.isEmpty
        return isCompanyIDValid && isUserValid && isBirthdayValid
    }
    
    private func isValidString(input: String?) -> Bool {
        guard let checkedInput = input else { return false }
        return !checkedInput.isEmpty
    }
    
    private func handleError(errorText: String) {
        stateObserver = .failed(errorText)
    }
}
