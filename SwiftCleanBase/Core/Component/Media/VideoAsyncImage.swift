//
//  MovieAsyncImage.swift
//  Movies
//  Created by グェン・ホン・ソン on 2024/06/12.
//

import SwiftUI

struct VideoAsyncImage: View {

    let url: URL?
    let shouldShowProgressView: Bool

    init(urlString: String?, isShowingProgressView: Bool = false) {
        self.url = URL(string: urlString ?? "")
        self.shouldShowProgressView = isShowingProgressView
    }

    var body: some View {
        CacheAsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                if shouldShowProgressView {
                    ProgressView()
                        .tint(.orangeBg)
                } else {
                    placeholder
                }

            case .success(let image):
                image
                    .resizable()
                    .transition(.scale(scale: Constants.scale, anchor: .center))

            case .failure:
                placeholder

            @unknown default:
                EmptyView()
            }
        }
    }

    private var placeholder: some View {
        Image(.moviePlaceholder)
            .resizable()
    }

    private enum Constants {
        static let scale = 0.1
    }
}
