//
//  RealmProvider.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import Foundation
import RealmSwift

struct RealmProvider {
    var realm: Realm { try! Realm() } // swiftlint:disable:this force_try
}
