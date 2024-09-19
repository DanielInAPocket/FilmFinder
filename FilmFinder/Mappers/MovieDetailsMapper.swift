//
//  MovieDetailsMapper.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import Foundation

struct MovieDetailsMapper {
    
    static func mapToDomain(_ dto: MovieDTO, actors: [PersonDTO]) -> MovieDetails {
        return MovieDetails(
            movieId: dto.id,
            overview: dto.overview,
            popularity: dto.popularity ?? 0,
            releaseDate: dto.releaseDate ?? "",
            runtime: dto.runtime ?? 0,
            originCountry: dto.originCountry?.first ?? "",
            actors: actors.map { PersonMapper.mapToDomain($0) }
        )
    }
    
    static func mapToDomain(_ dao: MovieDetailsDAO) -> MovieDetails {
        return MovieDetails(
            movieId: dao.movieId,
            overview: dao.overview,
            popularity: dao.popularity,
            releaseDate: dao.releaseDate,
            runtime: dao.runtime,
            originCountry: dao.originCountry,
            actors: dao.actors.map { PersonMapper.mapToDomain($0) }
        )
    }

    static func mapToDAO(_ model: MovieDetails) -> MovieDetailsDAO {
        MovieDetailsDAO(
            movieId: model.movieId,
            overview: model.overview,
            popularity: model.popularity,
            releaseDate: model.releaseDate,
            runtime: model.runtime,
            originCountry: model.originCountry,
            actors: model.actors.map { PersonMapper.mapToDAO($0) }
        )
    }
}
