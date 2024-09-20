//
//  HomeViewAction.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import Foundation

enum HomeViewAction: BaseViewAction {
    case loadNextPage(forList: ListType)
    case presentMovieDetails(Movie)
}
