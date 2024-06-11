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
                .tint(.loadingBackground)
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
                VStack {
                    Spacer()
                    ProgressIndicatorView(isPresented: $isPresented)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .animation(.easeInOut, value: isPresented)
                }
            }
        }
    }
}


