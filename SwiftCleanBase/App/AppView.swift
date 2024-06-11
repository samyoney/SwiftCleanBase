//
//  AppRouteView.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/11.
//

import Foundation
import SwiftUI

struct AppView<Content: View>: View {
    @StateObject private var router: AppRouter
    private let content: Content
    
    init(router: AppRouter, @ViewBuilder content: @escaping () -> Content) {
        _router = StateObject(wrappedValue: router)
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: AppRouter.Route.self) { route in
                    router.view(for: route)
                }
        }
        .sheet(item: $router.presentingSheet) { route in
            router.view(for: route)
        }
        .fullScreenCover(item: $router.presentingFullScreenCover) { route in
            router.view(for: route)
        }.environmentObject(router)
    }
}
