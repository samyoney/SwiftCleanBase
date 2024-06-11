//
//  View+Extension.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/11.
//

import Foundation
import SwiftUI

extension View {
    
    func observeLoadingState<T>(
        _ loadingState: Binding<LoadingState<T>>,
        onLoaded: @escaping (T?) -> Void = { _ in }
    ) -> some View {
        self.onError(loadingState, String())
            .onLoading(loadingState)
            .onLoaded(loadingState.wrappedValue, onNext: onLoaded)
    }
    
    func onError<T>(_ loadingState: Binding<LoadingState<T>>, _ title: String = String()) -> some View {
        var errorMsg = R.string.textFile.errorApiMessage()
        let isPresented = Binding<Bool>(
            get: {
                if case .error(let msg) = loadingState.wrappedValue {
                    errorMsg = msg
                    return true
                } else {
                    return false
                }
            },
            set: { newValue in
                if !newValue {
                    loadingState.wrappedValue = .idle
                }
            }
        )
        return self.modifier(ErroDialogModifier(isPresented: isPresented, title: title, message: errorMsg, buttonTitle: R.string.textFile.ok(), buttonAction: {
            loadingState.wrappedValue = .idle
        }))
    }
    
    
    func onLoading<T>(_ loadingState: Binding<LoadingState<T>>) -> some View {
        let isPresented = Binding<Bool>(
            get: {
                if case .loading = loadingState.wrappedValue {
                    return true
                } else {
                    return false
                }
            },
            set: { _ in
            }
        )
        return self.modifier(ProgressIndicatorModifier(isPresented: isPresented))
    }
    
    func onLoaded<T>(_ loadingState: LoadingState<T>, onNext: @escaping (T?) -> Void) -> some View {
        self.onChange(of: loadingState) {
            switch loadingState {
            case .loaded(let data): onNext(data)
            default: break
            }
        }
    }
}
