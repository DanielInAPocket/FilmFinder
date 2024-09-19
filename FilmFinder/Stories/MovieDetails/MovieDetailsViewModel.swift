//
//  MovieDetailsViewModel.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import Foundation
import Factory

class MovieDetailsViewModel: BaseViewModel<MovieDetailsViewAction, MovieDetailsViewState> {
    
    @Injected(\.movieRepository) private var movieRepository
    @Injected(\.trendingRouter) private var trendingRouter
    
    init(movie: Movie) {
        super.init(state: .init(movie: movie))
    }
    
    override func performAction(_ action: MovieDetailsViewAction) async {
        switch action {
        case .initialize:
            break
        case .pop:
            trendingRouter.pop()
        }
    }
}
