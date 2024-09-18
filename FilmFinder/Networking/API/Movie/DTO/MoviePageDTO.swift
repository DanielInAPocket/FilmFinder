//
//  MoviePageDTO.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation

struct MoviePageDTO {
    let page: Int
    let results: [MovieDTO]
    let totalPages: Int
    let totalResults: Int
}

extension MoviePageDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
