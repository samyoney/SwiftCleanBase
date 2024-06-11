//
//  SwiftCleanBaseApp.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/05/29.
//

import SwiftUI

@main
struct SwiftCleanBaseApp: App {
    @StateObject private var router: AppRouter = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            AppView(router: router) {
                router.getRootview()
            }
        }
    }
}
