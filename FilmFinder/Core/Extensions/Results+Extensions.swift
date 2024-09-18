//
//  Result+Extensions.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import Foundation
import RealmSwift

extension Results {
    func toArray() -> [Element] {
        compactMap { $0 }
    }
}
