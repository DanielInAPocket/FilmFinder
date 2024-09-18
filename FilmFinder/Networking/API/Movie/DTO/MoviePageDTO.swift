//
//  MoviePageDTO.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation

public struct MoviePageDTO {
    public let page: UInt
    public let results: [MovieDTO]
    public let totalPages: UInt
    public let totalResults: UInt

    public init(page: UInt, results: [MovieDTO], totalPages: UInt, totalResults: UInt) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}

extension MoviePageDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
