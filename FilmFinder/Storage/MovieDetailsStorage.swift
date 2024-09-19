//
//  MovieDetailsStorage.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import Foundation
import RealmSwift

protocol MovieDetailsStorage {
    func save(_ object: MovieDetailsDAO) throws
    
    func loadById(_ id: Int) throws -> MovieDetailsDAO

    func delete(_ object: MovieDetailsDAO) throws
}

class MovieDetailsStorageImplementation: BaseStorage<MovieDetailsDAO>, MovieDetailsStorage { }
