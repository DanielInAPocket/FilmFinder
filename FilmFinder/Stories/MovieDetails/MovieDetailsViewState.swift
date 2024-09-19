//
//  MovieDetailsViewState.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import Foundation

struct MovieDetailsViewState: BaseViewState {
    var isLoading = false
    var movie: Movie
    var details: MovieDetails = .empty
}
