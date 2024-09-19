//
//  TrendingViewState.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import Foundation

struct TrendingViewState: BaseViewState {
    var isLoading: Bool = false
    
    var page = 1
    var availablePages = 1
    var hasNextPage: Bool {
        page <= availablePages
    }
    
    var movies: [Movie] = []
}
