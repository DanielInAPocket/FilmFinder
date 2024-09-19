//
//  ListStorage.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import Foundation
import RealmSwift

protocol ListStorage {
    func override(_ object: ListDAO) throws
    func append(_ object: ListDAO) throws

    func loadTrending() throws -> ListDAO
    func loadWatchlist() throws -> ListDAO
    
    func deleteAll() throws
    func deleteByType(_ type: ListType) throws
}

class ListStorageImplementation: BaseStorage<ListDAO>, ListStorage {
    func override(_ object: ListDAO) throws {
        try save(object)
    }
    
    func append(_ object: ListDAO) throws {
        let list = try loadByType(object.type)
        try realm.write {
            list.movieIds.append(objectsIn: object.movieIds)
        }
    }
    
    private func loadByType(_ type: String) throws -> ListDAO {
        guard let object = realm.object(ofType: ListDAO.self, forPrimaryKey: type) else {
            throw StorageError.objectNotFound
        }
        return object
    }

    func loadTrending() throws -> ListDAO {
        return try loadByType(ListType.trending.rawValue)
    }
    
    func loadWatchlist() throws -> ListDAO {
        return try loadByType(ListType.watchList.rawValue)
    }
    
    func deleteByType(_ type: ListType) throws {
        let object = try loadByType(type.rawValue)
        try delete(object)
    }
}
