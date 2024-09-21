//
//  HomeRouter.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import SwiftUI
import Factory

enum HomeRoute: BaseRoute {
    case movieDetails(Movie)
}

extension HomeRoute: View {
    var body: some View {
        switch self {
        case .movieDetails(let movie):
            MovieDetailsView(movie: movie)
        }
    }
}

class HomeNavigationState: ObservableObject {
    @Published var routes: [HomeRoute] = []
}

@MainActor
class HomeRouter {
    
    @Injected(\.homeNavigationState) private var navigationState
    
    func showDetails(for movie: Movie) {
        navigationState.routes.append(.movieDetails(movie))
    }
}
