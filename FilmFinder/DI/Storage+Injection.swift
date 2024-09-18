//
//  Storage+Injection.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import Foundation
import Factory

extension Container {
    var realmProvider: Factory<RealmProvider> {
        self { RealmProvider() }
            .singleton
    }
    
    var movieStorage: Factory<MovieStorage> {
        self { MovieStorageImplementation() }
            .singleton
    }

    var listStorage: Factory<ListStorage> {
        self { ListStorageImplementation() }
            .singleton
    }
}
