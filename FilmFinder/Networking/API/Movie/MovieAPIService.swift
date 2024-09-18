//
//  MovieAPIService.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation
import Factory

protocol MovieAPIService {
    func getTrending(page: Int) async throws -> MoviePageDTO
}

final class MovieAPIServiceImplementation: MovieAPIService {
    
    @Injected(\.networkDispatcher) private var dispatcher
    
    func getTrending(page: Int) async throws -> MoviePageDTO {
        let request = MovieRequest.getTrending(page: page)
        let response: MoviePageDTO = try await dispatcher.fetch(with: request)
        return response
    }
}
