//
//  SearchRouter.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 21/09/2024.
//

import Foundation

protocol SearchRouter {
    func showDetails(for movie: Movie)
    func popToRoot()
    func show(toast: Toast)
}

class SearchRouterImplementation: BaseRouter<MovieRoute>, SearchRouter {
        
    func showDetails(for movie: Movie) {
        presentRoute(.movieDetails(movie))
    }
}
