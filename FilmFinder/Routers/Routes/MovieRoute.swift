//
//  MovieRoute.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 22/09/2024.
//

import Foundation
import SwiftUI

enum MovieRoute: BaseRoute {
    case movieDetails(Movie)
}

extension MovieRoute: View {
    var body: some View {
        switch self {
        case .movieDetails(let movie):
            MovieDetailsView(movie: movie)
        }
    }
}
