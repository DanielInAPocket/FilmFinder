//
//  CachedAsyncImage.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import SwiftUI
import NukeUI

struct CachedAsyncImage: View {
    private let url: URL?

    init(url: URL? = nil) {
        self.url = url
    }

    init(url: String) {
        self.url = URL(string: url)
    }

    var body: some View {
        LazyImage(url: url) { state in
            if let image = state.image {
                image
                    .resizable()
                    .scaledToFit()
            } else {
                Images.moviePlaceholder.image
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}
