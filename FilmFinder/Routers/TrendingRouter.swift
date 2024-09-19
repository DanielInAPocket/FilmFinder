//
//  TrendingRouter.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import SwiftUI
import Factory

enum TrendingRoute: BaseRoute {
    case movieDetails(Movie)
}

extension TrendingRoute: View {
    var body: some View {
        switch self {
        case .movieDetails(let movie):
            MovieDetailsView(movie: movie)
        }
    }
}

class TrendingNavigationState: ObservableObject {
    @Published var routes: [TrendingRoute] = []
}

@MainActor
class TrendingRouter {
    
    @Injected(\.trendingNavigationState) private var navigationState
    
    func showDetails(for movie: Movie) {
        navigationState.routes.append(.movieDetails(movie))
    }
}
