//
//  LoginInputField.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import Foundation
import SwiftUI

struct LoginInputField: View {
    @Binding var value: String

    var label: String
    var placeholder: String
    var helperText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.body)
            
            TextField(
                placeholder,
                text: $value,
                onEditingChanged: { _ in },
                onCommit: {}
            )
            .padding()
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .autocapitalization(.allCharacters)
            .keyboardType(.asciiCapable)
            .foregroundColor(Color.black)
            
            Text(helperText)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 16)
    }
}
