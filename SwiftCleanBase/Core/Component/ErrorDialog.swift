//
//  ErrorDialog.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/11.
//

import SwiftUI

struct ErrorDialog: View {
    @Binding var isPresented: Bool
    let title: String
    let message: String
    let buttonTitle: String
    let buttonAction: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            if !title.isEmpty {
                Text(title).font(.headline)
            }
            Text(message)
                .foregroundColor(.red)
                .font(.headline)
            Button(buttonTitle) {
                isPresented = false
                buttonAction()
            }
            .foregroundColor(.yellow)
        }
        .padding(EdgeInsets(top: 16, leading: 30, bottom: 16, trailing: 30))
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .frame(maxWidth: 300)
    }
}

struct ErroDialogModifier: ViewModifier {
    @Binding var isPresented: Bool
    let title: String
    let message: String
    let buttonTitle: String
    let buttonAction: () -> Void

    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                Color.black.opacity(0.4).ignoresSafeArea()
                ErrorDialog(isPresented: $isPresented, title: title, message: message, buttonTitle: buttonTitle, buttonAction: buttonAction)
            }
        }
    }
}
