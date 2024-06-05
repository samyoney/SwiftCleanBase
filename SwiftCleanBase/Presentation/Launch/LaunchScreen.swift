//
//  LaunchScreen.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/04.
//

import SwiftUI
import Resolver
import SwiftData

struct LaunchScreen: View {
    @Injected private var fetchAutoLoginUseCase: FetchAutoLoginUseCase
    @Injected private var fetchCoursesUseCase: FetchCoursesUseCase
    @Injected private var saveCoursesUseCase: SaveCoursesUseCase
    @Injected private var checkLoggedInUseCase: CheckLoggedInUseCase
    @Injected private var checkDataInitializedUseCase: CheckDataInitializedUseCase

    @State private var isLoading = true

    var body: some View {
        if isLoading {
            ZStack {
                Color(R.color.headerPinkColor)
                    .ignoresSafeArea()
                Image(R.image.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(100)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isLoading = false
                    }
                }
            }.task {
                let isInitialized = checkDataInitializedUseCase()
            }
        } else {
            if checkLoggedInUseCase() {
                LoginView()
            } else {
                SamView()
            }
            
        }
    }
}
