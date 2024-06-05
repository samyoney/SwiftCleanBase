//
//  LoginView.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/05/29.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel = .init()

    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case username, password, name
    }
    
    var body: some View {
        NavigationView {

            VStack {
                if viewModel.isRegisterScreen {
                    RegisterContentView(username: $viewModel.username, password: $viewModel.password, name: $viewModel.name, birth: $viewModel.birth, registerAction: {
                        viewModel.onRegister()
                    }, backToLoginAction: {
                        viewModel.onChangeMode()
                    })
                } else {
                    LoginContentView(username: $viewModel.username, password: $viewModel.password, loginAction: {
                        viewModel.onLogin()
                    }, goToRegisterAction: {
                        viewModel.onChangeMode()
                    })
                }
            }
            .navigationBarTitle(viewModel.isRegisterScreen ? R.string.textFile.register() : R.string.textFile.login(), displayMode: .inline)
            .onTapGesture {
                hideKeyboard()
            }
            .alert(isPresented: $viewModel.isShowingError) {
                Alert(
                    title: Text("Error"),
                    message: Text("Unknown error"),
                    dismissButton: .default(Text("OK")) {
                    }
                )
            }
        }
    }
    
    func hideKeyboard() {
        focusedField = nil
    }
}

struct LoginContentView: View {
    @Binding var username: String
    @Binding var password: String
    
    var loginAction: () -> Void
    var goToRegisterAction: () -> Void

    var body: some View {
        VStack {
            ExtraLargeSpacer()
            LoginInputField(
                label: R.string.textFile.name(),
                value: $username,
                placeholder: R.string.textFile.placeHolder(),
                helperText: R.string.textFile.description()
            )
            ExtraLargeSpacer()
            LoginInputField(
                label: R.string.textFile.password(),
                value: $password,
                placeholder: R.string.textFile.placeHolder(),
                helperText: R.string.textFile.description()
            )
            ExtraLargeSpacer()
            LoginButton(title: R.string.textFile.login()) {
                loginAction()
            }
            ExtraLargeSpacer()
            LoginButton(title: R.string.textFile.goToRegister()) {
                goToRegisterAction()
            }
        }
        .padding(.horizontal, 16)
    }
}

struct RegisterContentView: View {
    @Binding var username: String
    @Binding var password: String
    @Binding var name: String
    @Binding var birth: String
    
    var registerAction: () -> Void
    var backToLoginAction: () -> Void

    var body: some View {
        VStack {
            ExtraLargeSpacer()
            LoginInputField(
                label: R.string.textFile.name(),
                value: $username,
                placeholder: R.string.textFile.placeHolder(),
                helperText: R.string.textFile.description()
            )
            ExtraLargeSpacer()
            LoginInputField(
                label: R.string.textFile.password(),
                value: $password,
                placeholder: R.string.textFile.placeHolder(),
                helperText: R.string.textFile.description()
            )
            ExtraLargeSpacer()
            LoginInputField(
                label: R.string.textFile.name(),
                value: $name,
                placeholder: R.string.textFile.placeHolder(),
                helperText: R.string.textFile.description()
            )
            ExtraLargeSpacer()
            LoginBirthButton(birth: $birth) { year, month in
            }
            ExtraLargeSpacer()
            LoginButton(title: R.string.textFile.register()) {
                registerAction()
            }
            ExtraLargeSpacer()
            LoginButton(title: R.string.textFile.backToLogin()) {
                backToLoginAction()
            }
        }
        .padding(.horizontal, 16)
    }
}
