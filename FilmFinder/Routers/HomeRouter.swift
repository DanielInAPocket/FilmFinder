//
//  HomeRouter.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import Foundation

protocol HomeRouter {
    func showDetails(for movie: Movie)
    func popToRoot()
    func show(toast: Toast)
}

class HomeRouterImplementation: BaseRouter<MovieRoute>, HomeRouter {
    
    func showDetails(for movie: Movie) {
        presentRoute(.movieDetails(movie))
    }
}
