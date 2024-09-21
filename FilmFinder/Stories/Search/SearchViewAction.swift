//
//  SearchViewAction.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 21/09/2024.
//

import Foundation

enum SearchViewAction: BaseViewAction {
    case searchQuery(String?)
    case loadNextPage
    case presentMovieDetails(Movie)
}
