//
//  MovieDetails.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import Foundation

struct MovieDetails: Hashable, Identifiable {
    let movieId: Int
    let overview: String
    let popularity: Double
    let releaseYear: String
    let runtime: String
    let originCountry: String
    let actors: [Person]
    
    var id: Int {
        movieId
    }
}

extension MovieDetails {
    static var empty: MovieDetails {
        .init(
            movieId: 0,
            overview: "N/A",
            popularity: 0,
            releaseYear: "N/A",
            runtime: "N/A",
            originCountry: "N/A",
            actors: []
        )
    }
}
