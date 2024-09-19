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
    
    // MARK: - Movie
    
    static func mapToDomain(_ dto: MovieDTO) -> Movie {
        return Movie(
            id: dto.id,
            title: dto.title,
            originalTitle: dto.originalTitle,
            overview: dto.overview,
            posterPath: dto.posterPath,
            backdropPath: dto.backdropPath,
            genres: dto.genreIds,
            rating: dto.voteAverage
        )
    }
    
    static func mapToDomain(_ dao: MovieDAO) -> Movie {
        return Movie(
            id: dao.id,
            title: dao.title,
            originalTitle: dao.originalTitle,
            overview: dao.overview,
            posterPath: dao.posterPath,
            backdropPath: dao.backdropPath,
            genres: dao.genres.map { $0 },
            rating: dao.rating
        )
    }

    static func mapToDAO(_ model: Movie) -> MovieDAO {
        MovieDAO(
            id: model.id,
            title: model.title,
            originalTitle: model.originalTitle,
            overview: model.overview,
            posterPath: model.posterPath,
            backdropPath: model.backdropPath,
            genres: model.genres,
            rating: model.rating
        )
    }
}
