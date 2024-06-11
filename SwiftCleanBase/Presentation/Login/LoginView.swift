//
//  LoginView.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/05/29.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appRouter: AppRouter
    
    @StateObject var viewModel: LoginViewModel = .init()
    
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case username, password, name
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.state.isRegisterScreen {
                    RegisterContentView(username: $viewModel.state.username, password: $viewModel.state.password, name: $viewModel.state.name, birth: $viewModel.state.birth, registerAction: {
                        viewModel.onTriggerEvent(.register)
                    }, backToLoginAction: {
                        viewModel.onTriggerEvent(.changeLoginMode)
                    })
                } else {
                    LoginContentView(username: $viewModel.state.username, password: $viewModel.state.password, loginAction: {
                        viewModel.onTriggerEvent(.login)
                    }, goToRegisterAction: {
                        viewModel.onTriggerEvent(.changeLoginMode)
                    })
                }
            }.onChange(of: viewModel.state.loadingState == .loaded()) {
                appRouter.navigateTo(.sam)
            }
            .navigationBarTitle(viewModel.state.isRegisterScreen ? R.string.textFile.register() : R.string.textFile.login(), displayMode: .inline)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(R.color.statusBarColor), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .onTapGesture {
                hideKeyboard()
            }
            .observeLoadingState($viewModel.state.loadingState) { _ in
                appRouter.navigateTo(.sam)
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
                value: $username, label: R.string.textFile.name(),
                placeholder: R.string.textFile.placeHolder(),
                helperText: R.string.textFile.description()
            )
            ExtraLargeSpacer()
            LoginInputField(
                value: $password, label: R.string.textFile.password(),
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
                value: $username, label: R.string.textFile.name(),
                placeholder: R.string.textFile.placeHolder(),
                helperText: R.string.textFile.description()
            )
            ExtraLargeSpacer()
            LoginInputField(
                value: $password, label: R.string.textFile.password(),
                placeholder: R.string.textFile.placeHolder(),
                helperText: R.string.textFile.description()
            )
            ExtraLargeSpacer()
            LoginInputField(
                value: $name, label: R.string.textFile.name(),
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
