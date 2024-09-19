//
//  MovieStorage.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import Foundation
import RealmSwift

protocol MovieStorage {
    func save(_ object: MovieDAO) throws
    func save(contentsOf objects: [MovieDAO]) throws

    func loadAll() -> [MovieDAO]
    func loadById(_ id: Int) throws -> MovieDAO
    func loadByIds(_ ids: [Int]) throws -> [MovieDAO]

    func deleteAll() throws
    func delete(_ object: MovieDAO) throws
}

class MovieStorageImplementation: BaseStorage<MovieDAO>, MovieStorage {
    func loadByIds(_ ids: [Int]) throws -> [MovieDAO] {
        return loadAll().filter { ids.contains($0.id) }
    }
}
