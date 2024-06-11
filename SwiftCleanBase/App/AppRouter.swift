//
//  AppRouter.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/11.
//

import Foundation
import SwiftUI

class AppRouter: ObservableObject {
    enum NavigationType {
        case push
        case sheet
        case fullScreenCover
    }
    
    enum Route: Hashable, Identifiable {
        case launch
        case login
        case sam
        
        var id: Route {
            self
        }
    }
    @Published private var rootNav = Route.launch

    @Published var path: NavigationPath = NavigationPath()
    @Published var presentingSheet: Route?
    @Published var presentingFullScreenCover: Route?
    @Published var isPresented: Binding<Route?>
    
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .launch:
            LaunchView()
        case .login:
            LoginView()
        case .sam:
            SamView()
        }
    }
    
    @ViewBuilder func getRootview() -> some View {
        switch rootNav {
        case .launch:
            LaunchView()
        case .login:
            LoginView()
        case .sam:
            SamView()
        }
    }

    func router(navigationType: NavigationType) -> AppRouter {
        switch navigationType {
        case .push:
            return self
        case .sheet:
            return AppRouter(
                isPresented: Binding(
                    get: { self.presentingSheet },
                    set: { self.presentingSheet = $0 }
                )
            )
        case .fullScreenCover:
            return AppRouter(
                isPresented: Binding(
                    get: { self.presentingFullScreenCover },
                    set: { self.presentingFullScreenCover = $0 }
                )
            )
        }
    }
    
    func dismiss() {
        if !path.isEmpty {
            path.removeLast()
        } else if presentingSheet != nil {
            presentingSheet = nil
        } else if presentingFullScreenCover != nil {
            presentingFullScreenCover = nil
        } else {
            isPresented.wrappedValue = nil
        }
    }
    
    init(isPresented: Binding<Route?> = .constant(.launch)) {
        self.isPresented = isPresented
    }
    
    func setRootview(route: Route) {
        self.rootNav = route
    }
    
    func presentSheet(_ route: Route) {
        self.presentingSheet = route
    }
    
    func presentFullScreen(_ route: Route) {
        self.presentingFullScreenCover = route
    }
    
    func navigateTo(_ appRoute: Route) {
        path.append(appRoute)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}

