//
//  MovieStorage.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import Foundation
import Factory
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

class MovieStorageImplementation: MovieStorage {
    @Injected(\.realmProvider) private var realmProvider
    
    func save(_ object: MovieDAO) throws {
        try realmProvider.realm.write {
            realmProvider.realm.add(object, update: .modified)
        }
    }

    func save(contentsOf objects: [MovieDAO]) throws {
        try realmProvider.realm.write {
            for object in objects {
                realmProvider.realm.add(object, update: .modified)
            }
        }
    }
    
    func loadAll() -> [MovieDAO] {
        let results: Results<MovieDAO> = realmProvider.realm.objects(MovieDAO.self)
        return results.toArray()
    }
    
    func loadById(_ id: Int) throws -> MovieDAO {
        guard let object = realmProvider.realm.object(ofType: MovieDAO.self, forPrimaryKey: id) else {
            throw StorageError.objectNotFound
        }
        return object
    }
    
    func loadByIds(_ ids: [Int]) throws -> [MovieDAO] {
        return loadAll().filter { ids.contains($0.id) }
    }
    
    func deleteAll() throws {
        try realmProvider.realm.write {
            realmProvider.realm.objects(MovieDAO.self).forEach {
                realmProvider.realm.delete($0)
            }
        }
    }
    
    func delete(_ object: MovieDAO) throws {
        try realmProvider.realm.write {
            realmProvider.realm.delete(object)
        }
    }
}
