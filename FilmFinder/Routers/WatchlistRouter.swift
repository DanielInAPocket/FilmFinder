//
//  WatchlistRouter.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 22/09/2024.
//

import Foundation

protocol WatchlistRouter {
    func showDetails(for movie: Movie)
    func popToRoot()
    func show(toast: Toast)
}

class WatchlistRouterImplementation: BaseRouter<MovieRoute>, WatchlistRouter {
        
    func showDetails(for movie: Movie) {
        presentRoute(.movieDetails(movie))
    }
}
