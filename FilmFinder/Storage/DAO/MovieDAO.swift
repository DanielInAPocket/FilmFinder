//
//  MovieDAO.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import Foundation
import RealmSwift

class MovieDAO: Object {
    
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var originalTitle: String
    @Persisted var posterPath: String?
    @Persisted var backdropPath: String?
    @Persisted var genres: List<Int>
    @Persisted var rating: Double
    @Persisted var createdAt = Date()

    convenience init(
        id: Int,
        title: String,
        originalTitle: String,
        posterPath: String?,
        backdropPath: String?,
        genres: [Int],
        rating: Double,
        createdAt: Date = Date()
    ) {
        self.init()
        
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.genres.append(objectsIn: genres)
        self.rating = rating
        self.createdAt = createdAt
    }
}
