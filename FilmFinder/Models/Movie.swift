//
//  Movie.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation

struct Movie: Hashable, Identifiable {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let genres: [Int] // TODO: Replace with proper genre Model instead of IDs
    let rating: Double
}
