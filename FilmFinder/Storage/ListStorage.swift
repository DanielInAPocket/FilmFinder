//
//  ListStorage.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import Foundation
import Factory
import RealmSwift

protocol ListStorage {
    func override(_ object: ListDAO) throws
    func append(_ object: ListDAO) throws

    func loadTrending() throws -> ListDAO
    func loadWatchlist() throws -> ListDAO
    
    func deleteAll() throws
    func deleteByType(_ type: ListType) throws
}

class ListStorageImplementation: ListStorage {
    @Injected(\.realmProvider) private var realmProvider
    
    func override(_ object: ListDAO) throws {
        try realmProvider.realm.write {
            realmProvider.realm.add(object, update: .modified)
        }
    }
    
    func append(_ object: ListDAO) throws {
        let list = try loadByType(object.type)
        list.movieIds.append(objectsIn: object.movieIds)
        try realmProvider.realm.write {
            realmProvider.realm.add(list, update: .modified)
        }
    }
    
    private func loadByType(_ type: String) throws -> ListDAO {
        guard let object = realmProvider.realm.object(ofType: ListDAO.self, forPrimaryKey: type) else {
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
    
    func deleteAll() throws {
        try realmProvider.realm.write {
            realmProvider.realm.objects(MovieDAO.self).forEach {
                realmProvider.realm.delete($0)
            }
        }
    }
    
    func deleteByType(_ type: ListType) throws {
        let object = try loadByType(type.rawValue)
        try realmProvider.realm.write {
            realmProvider.realm.delete(object)
        }
    }
}
