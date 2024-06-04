//
//  LoginView.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/05/29.
//

import SwiftUI

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var name: String = ""
    @State var birth: String = ""
    @State var isRegisterScreen = false
    @State var isShowError = false

    @Environment(\.dismiss) private var dismiss
    
    
    @FocusState private var focusedField: Field?
    enum Field: Hashable {
        case username, password, name
    }
    
    var body: some View {
        NavigationView {

            VStack {
                if isRegisterScreen {
                    RegisterContentView(username: $username, password: $password, name: $name, birth: $birth)
                } else {
                    LoginContentView(username: $username, password: $password)
                }
            }
            .navigationBarTitle(isRegisterScreen ? "Register" : "Login", displayMode: .inline)
            .onTapGesture {
                hideKeyboard()
            }
            .alert(isPresented: $isShowError) {
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
    
    var body: some View {
        VStack {
            LoginInputField(
                label: R.string.textFile.name(),
                value: $username,
                placeholder: "Enter your username",
                helperText: "Username description"
            )
            .padding(.top, 38)
            LoginInputField(
                label: "Password",
                value: $password,
                placeholder: "Enter your password",
                helperText: "Password description"
            )
            .padding(.top, 20)
            Spacer().frame(height: 30)
            LoginButton(title: "Login") {
            }
            Spacer().frame(height: 30)
            LoginButton(title: "Go to Register") {
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
    
    var body: some View {
        VStack {
            LoginInputField(
                label: "Username",
                value: $username,
                placeholder: "Enter your username",
                helperText: "Username description"
            )
            .padding(.top, 38)
            LoginInputField(
                label: "Password",
                value: $password,
                placeholder: "Enter your password",
                helperText: "Password description"
            )
            .padding(.top, 20)
            LoginInputField(
                label: "Name",
                value: $name,
                placeholder: "Enter your name",
                helperText: "Name description"
            )
            .padding(.top, 20)
            LoginBirthButton(birth: $birth) { year, month in
            }
            Spacer().frame(height: 30)
            LoginButton(title: "Register") {
            }
            Spacer().frame(height: 30)
            LoginButton(title: "Back to Login") {
            }
        }
        .padding(.horizontal, 16)
    }
}
