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
    @StateObject var viewModel: LaunchViewModel = .init()
    
    var body: some View {
        switch(viewModel.state) {
        case .idle:
            ZStack {
                Color(R.color.headerPinkColor)
                    .ignoresSafeArea()
                Image(R.image.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(100)
            }.onAppear {
                viewModel.onTriggerEvent(.initData)
            }
        case .loaded(let data):
            if data?.isNextToSam == true {
                SamView()
            } else {
                LoginView()
            }
        default: EmptyView()
        }
    }
}
