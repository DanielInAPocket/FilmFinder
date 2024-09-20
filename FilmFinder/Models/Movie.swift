//
//  Movie.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation

struct Movie: Hashable, Identifiable {
    let id: Int
    let title: String
    let posterUrl: URL?
    let rating: Double
}

extension Movie {
    static var empty: Movie {
        Movie(
            id: 0,
            title: "Movie Title",
            posterUrl: nil,
            rating: 0
        )
    }
}
