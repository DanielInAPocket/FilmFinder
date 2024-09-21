//
//  SearchRouter.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 21/09/2024.
//

import SwiftUI
import Factory

enum SearchRoute: BaseRoute {
    case movieDetails(Movie)
}

extension SearchRoute: View {
    var body: some View {
        switch self {
        case .movieDetails(let movie):
            MovieDetailsView(movie: movie)
        }
    }
}

class SearchNavigationState: ObservableObject {
    @Published var routes: [SearchRoute] = []
    @Published var toast: Toast?
}

@MainActor
class SearchRouter {
    
    @Injected(\.searchNavigationState) private var navigationState
    
    func showDetails(for movie: Movie) {
        navigationState.routes.append(.movieDetails(movie))
    }
    
    func popToRoot() {
        navigationState.routes = []
    }
    
    func show(toast: Toast) {
        withAnimation {
            navigationState.toast = toast
        }
    }
}
