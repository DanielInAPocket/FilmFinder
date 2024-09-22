//
//  WatchListViewModel.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 22/09/2024.
//

import Foundation
import Factory
import Combine

class WatchListViewModel: BaseViewModel<WatchListViewAction, WatchListViewState> {
    
    @Injected(\.movieRepository) private var movieRepository
    @Injected(\.watchlistRouter) private var watchlistRouter
    
    private let querySubject = CurrentValueSubject<String?, Never>(nil)
    private var searchTask: Task<()?, Never>?

    init() {
        super.init(state: .init())
    }
    
    override func performAction(_ action: WatchListViewAction) async {
        switch action {
        case .loadMovies:
            await loadMovies()
        case .presentMovieDetails(let movie):
            watchlistRouter.showDetails(for: movie)
        }
    }
}

private extension WatchListViewModel {
    
    func loadMovies() async {
        let result = await movieRepository.getMovies(forList: .watchlist, page: 1)
        
        if let moviePage = result.getData() {
            state.movies = moviePage.movies
        }

        if let error = result.getError() {
            show(error: error)
        }
    }
    
    func show(error: Error) {
        switch error {
        case _ as ApiError:
            break
        default:
            watchlistRouter.show(toast: Toast.error(from: error))
        }
    }
}
