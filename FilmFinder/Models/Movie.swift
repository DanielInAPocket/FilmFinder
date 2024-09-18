//
//  Movie.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation

struct Movie: Hashable, Identifiable {
    let id: UInt
    let title: String
    let originalTitle: String
    let posterPath: String?
    let backdropPath: String?
    let genres: [UInt] // TODO: Replace with proper genre Model instead of IDs
    let rating: Double
}
