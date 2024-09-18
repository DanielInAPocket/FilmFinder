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
    
    @Injected(\.movieAPIService) private var apiService
    @Injected(\.listStorage) private var listStorage
    @Injected(\.movieStorage) private var movieStorage
    
    func getTrending(page: Int) async -> RepositoryResult<MoviePage> {
        do {
            let moviePage = try await tryFetchAndSaveTrendingMovies(page: page)
            return .latest(data: moviePage)
        } catch {
            do {
                let moviePage = try tryLoadingCachedTrendingMovies()
                return .fallback(data: moviePage, error: error)
            } catch {
                return .failure(error: error)
            }
        }
    }
}

private extension MovieRepositoryImplementation {
    func tryFetchAndSaveTrendingMovies(page: Int) async throws -> MoviePage {
        let moviePageDTO = try await apiService.getTrending(page: page)
        let moviePage = MovieMapper.mapToDomain(moviePageDTO)

        try movieStorage.save(contentsOf: moviePage.movies.map { MovieMapper.mapToDAO($0) })

        // NOTE: We override trending list storage for 1st page fetch to always store latest trends
        if page == 1 {
            try listStorage.override(.init(type: ListType.trending.rawValue, movieIds: moviePage.movies.map { $0.id }))
        } else {
            try listStorage.append(.init(type: ListType.trending.rawValue, movieIds: moviePage.movies.map { $0.id }))
        }

        return moviePage
    }
    
    func tryLoadingCachedTrendingMovies() throws -> MoviePage {
        let listDAO = try listStorage.loadTrending()
        let movieDAOs = try movieStorage.loadByIds(Array(listDAO.movieIds))
        let movies = movieDAOs.map { MovieMapper.mapToDomain($0) }
        
        return MoviePage(page: 1, movies: movies, totalPages: 1)
    }
}
