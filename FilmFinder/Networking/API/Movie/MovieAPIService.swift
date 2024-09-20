//
//  MovieAPIService.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation
import Factory

protocol MovieAPIService {
    func getMovies(forList list: ListType, page: Int) async throws -> MoviePageDTO
    func getMovieDetails(forId id: Int) async throws -> MovieDTO
}

final class MovieAPIServiceImplementation: MovieAPIService {
    
    @Injected(\.networkDispatcher) private var dispatcher
    
    func getMovies(forList list: ListType, page: Int) async throws -> MoviePageDTO {
        switch list {
        case .nowPlaying: return try await getNowPlaying(page: page)
        case .popular: return try await getPopular(page: page)
        case .trending: return try await getTrending(page: page)
        }
    }
    
    private func getNowPlaying(page: Int) async throws -> MoviePageDTO {
        let request = MovieRequest.getNowPlaying(page: page)
        let response: MoviePageDTO = try await dispatcher.fetch(with: request)
        return response
    }
    
    private func getPopular(page: Int) async throws -> MoviePageDTO {
        let request = MovieRequest.getPopular(page: page)
        let response: MoviePageDTO = try await dispatcher.fetch(with: request)
        return response
    }

    private func getTrending(page: Int) async throws -> MoviePageDTO {
        let request = MovieRequest.getTrending(page: page)
        let response: MoviePageDTO = try await dispatcher.fetch(with: request)
        return response
    }

    func getMovieDetails(forId id: Int) async throws -> MovieDTO {
        let request = MovieRequest.getMovieDetails(id: id)
        let response: MovieDTO = try await dispatcher.fetch(with: request)
        return response
    }
}
