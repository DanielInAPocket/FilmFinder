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
        var posterUrl: URL?
        if let posterPath = dto.posterPath {
            posterUrl = URL(string: "https://image.tmdb.org/t/p/original/\(posterPath)")
        }
        
        return Movie(
            id: dto.id,
            title: dto.title,
            posterUrl: posterUrl,
            rating: dto.voteAverage
        )
    }
    
    static func mapToDomain(_ dao: MovieDAO) -> Movie {
        var posterUrl: URL?
        if let posterUrlString = dao.posterUrl {
            posterUrl = URL(string: posterUrlString)
        }

        return Movie(
            id: dao.id,
            title: dao.title,
            posterUrl: posterUrl,
            rating: dao.rating
        )
    }

    static func mapToDAO(_ model: Movie) -> MovieDAO {
        MovieDAO(
            id: model.id,
            title: model.title,
            posterUrl: model.posterUrl?.absoluteString,
            rating: model.rating
        )
    }
}
