//
//  MovieDetailsDAO.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import Foundation
import RealmSwift

class MovieDetailsDAO: Object {
    
    @Persisted(primaryKey: true) var movieId: Int
    @Persisted var overview: String
    @Persisted var popularity: Double
    @Persisted var releaseYear: String
    @Persisted var runtime: String
    @Persisted var originCountry: String
    @Persisted var actors: List<PersonDAO>

    convenience init(
        movieId: Int,
        overview: String,
        popularity: Double,
        releaseYear: String,
        runtime: String,
        originCountry: String,
        actors: [PersonDAO]
    ) {
        self.init()
        
        self.movieId = movieId
        self.overview = overview
        self.popularity = popularity
        self.releaseYear = releaseYear
        self.runtime = runtime
        self.originCountry = originCountry
        self.actors.append(objectsIn: actors)
    }
}
