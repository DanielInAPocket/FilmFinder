//
//  MovieDetailsViewModel.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import Foundation
import Factory

class MovieDetailsViewModel: BaseViewModel<MovieDetailsViewAction, MovieDetailsViewState> {
    
    @Injected(\.movieRepository) private var movieRepository
    @Injected(\.homeRouter) private var homeRouter
    
    init(movie: Movie) {
        super.init(state: .init(movie: movie))
    }
    
    override func performAction(_ action: MovieDetailsViewAction) async {
        switch action {
        case .initialize:
            await initialize()
        case .toggleWatchlist:
            break
        }
    }
}

private extension MovieDetailsViewModel {
        
    func initialize() async {
        state.isLoading = true
        defer {
            state.isLoading = false
        }
        
        let result = await movieRepository.getDetails(forMovieId: state.movie.id)
        
        if let details = result.getData() {
            state.details = details
        }
        
        if let error = result.getError() {
            show(error: error)
        }
    }
    
    func show(error: Error) {
        switch error {
        case let error as NetworkError where error.errorType == .noInternetConnection:
            let toast = Toast.error(
                title: Strings.toastErrorTitle,
                subtitle: Strings.toastNoCacheMessage
            )
            return homeRouter.show(toast: toast)
        default:
            homeRouter.show(toast: Toast.error(from: error))
        }
    }
}
