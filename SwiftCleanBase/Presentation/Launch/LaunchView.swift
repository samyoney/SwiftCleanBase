//
//  LaunchView.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import SwiftUI
import Resolver
import SwiftData

struct LaunchView: View {
    @EnvironmentObject var appRouter: AppRouter

    @StateObject var viewModel: LaunchViewModel = .init()
    
    var body: some View {
        ZStack {
            Color(R.color.orangeBgColor)
                .ignoresSafeArea()
            Image(R.image.logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(100)
        }.onAppear {
            viewModel.onTriggerEvent(.initData)
        }.onLoaded(viewModel.state) { data in
            if data?.isNextToSam == true {
                appRouter.setRootview(route: .sam)
            } else {
                appRouter.setRootview(route: .login)
            }
        }
    }
}
