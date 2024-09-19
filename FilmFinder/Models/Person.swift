//
//  Person.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import Foundation

struct Person: Hashable, Identifiable {
    let id: Int
    let name: String
    let profileUrl: URL?
}
