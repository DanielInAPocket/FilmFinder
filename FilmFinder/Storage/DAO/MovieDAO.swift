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
    @Persisted var posterUrl: String?
    @Persisted var rating: Double

    convenience init(
        id: Int,
        title: String,
        posterUrl: String?,
        rating: Double
    ) {
        self.init()
        
        self.id = id
        self.title = title
        self.posterUrl = posterUrl
        self.rating = rating
    }
}
