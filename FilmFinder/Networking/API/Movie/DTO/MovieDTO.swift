//
//  MovieDTO.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation

struct MovieDTO {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let voteAverage: Double
    let popularity: Double?
    let releaseDate: String?
    let runtime: Int?
    let originCountry: [String]?
    let credits: CreditsDTO?
}

extension MovieDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case popularity
        case releaseDate = "release_date"
        case runtime
        case originCountry = "origin_country"
        case credits
    }
}
