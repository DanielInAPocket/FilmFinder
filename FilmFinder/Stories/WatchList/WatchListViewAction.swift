//
//  WatchListViewAction.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 22/09/2024.
//

import Foundation

enum WatchListViewAction: BaseViewAction {
    case loadMovies
    case presentMovieDetails(Movie)
}
