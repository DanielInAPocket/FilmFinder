//
//  MovieRepository.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation
import Factory

protocol MovieRepository {
    func getTrending(page: Int) async -> RepositoryResult<MoviePage>
}

class MovieRepositoryImplementation: MovieRepository {
    
    private let apiService: MovieAPIService
    
    init(apiService: MovieAPIService) {
        self.apiService = apiService
    }

    // TODO: Add cache support
    func getTrending(page: Int) async -> RepositoryResult<MoviePage> {
        do {
            let moviePageDTO = try await self.apiService.getTrending(page: page)
            
            let moviePage = MovieMapper.mapToDomain(moviePageDTO)
            return .latest(data: moviePage)
        } catch {
            return .failure(error: error)
        }
    }
}
