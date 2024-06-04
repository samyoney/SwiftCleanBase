//
//  Spacer.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import SwiftUI

let dimen4: CGFloat = 4
let dimen6: CGFloat = 6
let dimen12: CGFloat = 12
let dimen18: CGFloat = 18
let dimen20: CGFloat = 20
let dimen24: CGFloat = 24
let dimen30: CGFloat = 30

struct DefaultSpacer: View {
    var body: some View {
        Spacer()
            .frame(height: dimen4)
            .frame(maxWidth: .infinity)
    }
}

struct ExtraSmallSpacer: View {
    var body: some View {
        Spacer()
            .frame(height: dimen6)
            .frame(maxWidth: .infinity)
    }
}

struct SmallSpacer: View {
    var body: some View {
        Spacer()
            .frame(height: dimen12)
            .frame(maxWidth: .infinity)
    }
}

struct MediumHeightSpacer: View {
    var body: some View {
        Spacer()
            .frame(height: dimen18)
            .frame(maxWidth: .infinity)
    }
}

struct Width20Spacer: View {
    var body: some View {
        Spacer()
            .frame(width: dimen20)
    }
}

struct LargeSpacer: View {
    var body: some View {
        Spacer()
            .frame(height: dimen24)
            .frame(maxWidth: .infinity)
    }
}

struct ExtraLargeSpacer: View {
    var body: some View {
        Spacer()
            .frame(height: dimen30)
            .frame(maxWidth: .infinity)
    }
}

struct KeyboardSpacer: View {
    @State private var keyboardHeight: CGFloat = 0
    let confirmHeight: (CGFloat) -> CGFloat
    
    var body: some View {
        Spacer()
            .frame(height: keyboardHeight)
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    keyboardHeight = confirmHeight(keyboardFrame.height)
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                keyboardHeight = 0
            }
    }
    
    init(confirmHeight: @escaping (CGFloat) -> CGFloat = { $0 }) {
        self.confirmHeight = confirmHeight
    }
}

