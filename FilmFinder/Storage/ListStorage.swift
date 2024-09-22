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
    func remove(_ object: ListDAO) throws

    func loadBy(type: ListType) throws -> ListDAO
    
    func deleteAll() throws
    func deleteBy(type: ListType) throws
}

class ListStorageImplementation: BaseStorage<ListDAO>, ListStorage {
    func override(_ object: ListDAO) throws {
        try save(object)
    }
        
    func append(_ object: ListDAO) throws {
        let list = try loadBy(typeString: object.type)
        try realm.write {
            list.movieIds.append(objectsIn: object.movieIds)
        }
    }

    func remove(_ object: ListDAO) throws {
        let list = try loadBy(typeString: object.type)
        try realm.write {
            var filteredMovieIds = List<Int>()
            filteredMovieIds.append(objectsIn: Array(list.movieIds).filter { !object.movieIds.contains($0) })
            list.movieIds = filteredMovieIds
        }
    }

    private func loadBy(typeString type: String) throws -> ListDAO {
        guard let object = realm.object(ofType: ListDAO.self, forPrimaryKey: type) else {
            throw StorageError.objectNotFound
        }
        return object
    }

    func loadBy(type: ListType) throws -> ListDAO {
        return try loadBy(typeString: type.rawValue)
    }
    
    func deleteBy(type: ListType) throws {
        let object = try loadBy(typeString: type.rawValue)
        try delete(object)
    }
}
