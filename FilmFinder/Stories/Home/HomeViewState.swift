//
//  HomeViewState.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import Foundation

struct HomeViewState: BaseViewState {    
    var nowPlaying: SectionState = .init(listType: .nowPlaying)
    var popular: SectionState = .init(listType: .popular)
    var trending: SectionState = .init(listType: .trending)
}

struct SectionState {
    let listType: ListType
    
    var isLoading = false
    
    var page = 1
    var availablePages = 1
    var hasNextPage: Bool {
        page <= availablePages
    }
    
    var movies: [Movie] = []
}
