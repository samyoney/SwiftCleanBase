//
//  LoginButton.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import SwiftUI

struct LoginButton: View {
    var title: String
    var onClick: () -> Void
    
    var body: some View {
        Button(action: {
            onClick()
        }) {
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(Color(R.color.orangeBgColor))
                .foregroundColor(Color(R.color.baseColor))
                .cornerRadius(8)
                .padding(.horizontal, 38)
        }
    }
}
