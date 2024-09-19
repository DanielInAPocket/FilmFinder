//
//  TrendingViewAction.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import Foundation

enum TrendingViewAction: BaseViewAction {
    case loadNextPage
    case presentMovieDetails(Movie)
}
