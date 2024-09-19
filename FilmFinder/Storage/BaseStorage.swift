//
//  BaseStorage.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import Foundation
import Factory
import RealmSwift

open class BaseStorage<T: Object> {
    
    @Injected(\.realmProvider) private var realmProvider

    var realm: Realm {
        realmProvider.realm
    }
    
    public func save(_ object: T) throws {
        try realm.write {
            realm.add(object, update: .modified)
        }
    }

    public func save(contentsOf objects: [T]) throws {
        try realm.write {
            for object in objects {
                realm.add(object, update: .modified)
            }
        }
    }
    
    public func loadById<KeyType>(_ id: KeyType) throws -> T {
        guard let object = realm.object(ofType: T.self, forPrimaryKey: id) else {
            throw StorageError.objectNotFound
        }
        return object
    }

    public func loadAll() -> Results<T> {
        realm.objects(T.self)
    }
    
    public func loadAll() -> [T] {
        let results: Results<T> = loadAll()
        return results.toArray()
    }
    
    public func delete(_ object: T) throws {
        try realm.write {
            realm.delete(object)
        }
    }

    public func deleteAll() throws {
        try realm.write {
            realm.objects(T.self).forEach {
                realm.delete($0)
            }
        }
    }
}
