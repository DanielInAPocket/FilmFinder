//
//  PersonDAO.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import Foundation
import RealmSwift

class PersonDAO: Object {
    
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var profileUrl: String?
    @Persisted var createdAt = Date()

    convenience init(
        id: Int,
        name: String,
        profileUrl: String?,
        createdAt: Date = Date()
    ) {
        self.init()
        
        self.id = id
        self.name = name
        self.profileUrl = profileUrl
        self.createdAt = createdAt
    }
}
