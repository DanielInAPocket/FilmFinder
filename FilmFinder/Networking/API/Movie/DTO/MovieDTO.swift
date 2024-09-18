//
//  MovieDTO.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation

public struct MovieDTO {
    public let id: UInt
    public let title: String
    public let originalTitle: String
    public let posterPath: String?
    public let backdropPath: String?
    public let genreIds: [UInt]
    public let voteAverage: Double

    public init(id: UInt, title: String, originalTitle: String, posterPath: String?, backdropPath: String?, genreIds: [UInt], voteAverage: Double) {
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.genreIds = genreIds
        self.voteAverage = voteAverage
    }
}

extension MovieDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case voteAverage = "vote_average"
    }
}
