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
            releaseYear: mapReleaseDateToYearString(dto.releaseDate ?? ""),
            runtime: mapRuntimeToString(dto.runtime ?? 0),
            originCountry: dto.originCountry?.first ?? "",
            actors: actors.map { PersonMapper.mapToDomain($0) }
        )
    }
    
    static func mapToDomain(_ dao: MovieDetailsDAO) -> MovieDetails {
        return MovieDetails(
            movieId: dao.movieId,
            overview: dao.overview,
            popularity: dao.popularity,
            releaseYear: dao.releaseYear,
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
            releaseYear: model.releaseYear,
            runtime: model.runtime,
            originCountry: model.originCountry,
            actors: model.actors.map { PersonMapper.mapToDAO($0) }
        )
    }
}

private extension MovieDetailsMapper {
    
    static func mapRuntimeToString(_ runtime: Int) -> String {
        let hours = runtime / 60
        let minutes = runtime % 60
        return "\(hours)h \(minutes)m"
    }
    
    static func mapReleaseDateToYearString(_ releaseDate: String) -> String {
        let dateFormatter = DateFormatter.iso8601
        let date = dateFormatter.date(from: releaseDate)
        if let date {
            return "\(Calendar.current.component(.year, from: date))"
        } else {
            return "N/A"
        }
    }
}
