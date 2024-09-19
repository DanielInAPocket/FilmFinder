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
    let releaseDate: String
    let runtime: Int
    let originCountry: String
    let actors: [Person]
    
    var id: Int {
        movieId
    }
    
    static var empty: MovieDetails {
        .init(
            movieId: 0,
            overview: "N/A",
            popularity: 0,
            releaseDate: "N/A",
            runtime: 0,
            originCountry: "N/A",
            actors: []
        )
    }
}
