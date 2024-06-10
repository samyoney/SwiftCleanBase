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
    
    @Published var state: LoginState = .init()
    
    func onTriggerEvent(_ eventType: LoginEvent) {
        switch eventType {
        case .inputUsername(let text):
            onInputUsername(text)
        case .inputPassword(let text):
            onInputPassword(text)
        case .inputName(let text):
            onInputName(text)
        case .inputBirth(let year, let month):
            onInputBirth(year, month)
        case .register:
            onRegister()
        case .login:
            onLogin()
        case .changeLoginMode:
            onChangeMode()
        case .idleReturn:
            onIdle()
        }
    }
    
    private func onChangeMode() {
        state.isRegisterScreen = !state.isRegisterScreen
    }
    
    private func onLogin() {
        if !checkValidation(state.username, state.password) {
            handleError(R.string.textFile.validationFailText())
            return
        }
        fetchLoginUseCase(username: state.username, password: state.password, { error in
            self.handleError(error.message)
        }, { res in
            if (res.status == 0) {
                self.handleAfterLogin(self.state.username, self.state.password)
            } else {
                self.handleError(R.string.textFile.errorApiMessage())
            }
        })
    }
    
    private func handleAfterLogin(_ username: String, _ password: String) {
        fetchStudentsData  { res in
            self.saveStudents(res: res)
            self.saveAccountInfo(username, password)
            self.state.loadingState = .loaded()
        }
    }
    
    private func onIdle() {
        self.state.loadingState = .idle
    }
    
    private func onRegister() {
        if (!checkValidation(state.username, state.password, state.birth)) {
            self.state.loadingState = .error(R.string.textFile.validationFailText())
            return
        }
        
        fetchRegisterUseCase(username: state.username, password: state.password, courseId: String(), name: state.name, birth: state.birth, {
            err in
            self.handleError(err.message)
        }, {
            res in
                if (res.status == 0) {
                    self.handleAfterLogin(self.state.username, self.state.password)
                } else {
                    self.handleError(R.string.textFile.errorApiMessage())
                }
        })
    }
    
    private func fetchStudentsData(onFinish: @escaping(_ res: StudentResponse) -> Void) {
        fetchStudentsUseCase({ err in self.handleError(err.message)},
                             { res in
            if (res.status == 0) {
                onFinish(res)
            } else {
                self.handleError(R.string.textFile.errorApiMessage())
            }
        })
    }
    
    private func saveAccountInfo(_ username: String, _ password: String) {
        saveAccountInfoUseCase(username: username, password: password)
    }
    
    private func saveStudents(res: StudentResponse) {
        saveStudentsUseCase(students: res.students)
    }
    
    private func onInputBirth(_ year: Int, _ month: Int) {
        state.birth = "\(year)/\(month)"
    }
    
    private func onInputName(_ text: String) {
        state.username = text
    }
    
    private func onInputPassword(_ text: String) {
        if (text.isEmpty || (text.range(of: "^[A-Z0-9a-z]+$", options: .regularExpression) != nil) && text.count <= 16) {
            state.password = text.uppercased(with: Locale(identifier: "en_US"))
        }
    }
    
    private func onInputUsername(_ text: String) {
        if (text.isEmpty || (text.range(of: "^[A-Z0-9a-z]+$", options: .regularExpression) != nil) && text.count <= 16) {
            state.username = text.uppercased(with: Locale(identifier: "en_US"))
        }
    }
    
    private func checkValidation(_ username: String? = nil, _ password: String? = nil, _ birthday: String? = nil) -> Bool {
        let isUsernameValid = username != nil
        let isPasswordValid = password != nil
        let isBirthdayValid = birthday == nil || !birthday!.isEmpty
        return isUsernameValid && isPasswordValid && isBirthdayValid
    }
    
    private func isValidString(input: String?) -> Bool {
        guard let checkedInput = input else { return false }
        return !checkedInput.isEmpty
    }
    
    private func handleError(_ errorText: String) {
        state.loadingState = .error(errorText)
    }
}
