//
//  WatchListViewState.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 22/09/2024.
//

import Foundation

struct WatchListViewState: BaseViewState {
    var isLoading = false
    var movies: [Movie] = []
}
