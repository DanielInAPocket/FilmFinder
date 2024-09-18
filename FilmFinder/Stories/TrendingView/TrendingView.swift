//
//  TrendingView.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 17/09/2024.
//

import SwiftUI
import Factory

struct TrendingView: View {
    @Injected(\.movieRepository) private var movieRepository
    
    var body: some View {
        Color.red
            .task {
                let result = await movieRepository.getTrending(page: 1)
                print(result.getError())
                print(result.getData())
            }
    }
}
