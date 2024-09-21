//
//  SearchViewState.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 21/09/2024.
//

import Foundation

struct SearchViewState: BaseViewState {
    var isLoading = false
    
    var searchedQuery = ""
    var page = 1
    var availablePages = 0
    var hasNextPage: Bool {
        page <= availablePages
    }
    
    var movies: [Movie] = []
}
