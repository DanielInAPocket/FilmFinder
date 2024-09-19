//
//  TrendingViewModel.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import Foundation
import Factory

class TrendingViewModel: BaseViewModel<TrendingViewAction, TrendingViewState> {
    
    @Injected(\.movieRepository) private var movieRepository
    @Injected(\.trendingRouter) private var trendingRouter
    
    init() {
        super.init(state: .init())
    }
    
    override func performAction(_ action: TrendingViewAction) async {
        switch action {
        case .loadNextPage:
            await fetchPage(page: state.page)
        case .presentMovieDetails(let movie):
            trendingRouter.showDetails(for: movie)
        }
    }
}

private extension TrendingViewModel {
        
    func initialize() async {
        await fetchPage(page: 1)
    }
    
    func fetchPage(page: Int) async {
        state.isLoading = true
        defer {
            state.isLoading = false
        }

        guard page <= state.availablePages else {
            return
        }
        
        let result = await movieRepository.getTrending(page: state.page)
        
        if let moviePage = result.getData() {
            state.movies.append(contentsOf: moviePage.movies)
            state.page += 1
            state.availablePages = moviePage.totalPages
        }
        
        if let error = result.getError() {
            show(error: error)
        }
    }
    
    func show(error: Error) {
        print("TODO: Imeplement error handling") // TODO: Implement
    }
}
