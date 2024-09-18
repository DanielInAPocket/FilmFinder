//
//  MovieMapper.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation

struct MovieMapper {
    
    static func mapToDomain(_ dto: MoviePageDTO) -> MoviePage {
        return MoviePage(
            page: dto.page,
            movies: dto.results.map { mapToDomain($0) },
            totalPages: dto.totalPages
        )
    }
    
    static func mapToDomain(_ dto: MovieDTO) -> Movie {
        return Movie(
            id: dto.id,
            title: dto.title,
            originalTitle: dto.originalTitle,
            posterPath: dto.posterPath,
            backdropPath: dto.backdropPath,
            genres: dto.genreIds,
            rating: dto.voteAverage
        )
    }
}
