//
//  ProgressIndicator.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/11.
//

import Foundation
import SwiftUI

struct ProgressIndicatorView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        if isPresented {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(2)
                .tint(.orangeBg)
                .frame(maxWidth: .infinity)
        }
    }
}

struct ProgressIndicatorModifier: ViewModifier {
    @Binding var isPresented: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                ZStack {
                    Color.black.opacity(0.6)
                    Spacer()
                    ProgressIndicatorView(isPresented: $isPresented)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .animation(.easeInOut, value: isPresented)
                }
            }
        }
    }
}


