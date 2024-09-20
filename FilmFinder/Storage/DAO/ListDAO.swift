//
//  ListDAO.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import Foundation
import RealmSwift

class ListDAO: Object {
    
    @Persisted(primaryKey: true) var type: String
    @Persisted var movieIds: List<Int>
    @Persisted var createdAt = Date()

    convenience init(
        type: String,
        movieIds: [Int],
        createdAt: Date = Date()
    ) {
        self.init()
        
        self.type = type
        self.movieIds.append(objectsIn: movieIds)
        self.createdAt = createdAt
    }
}
