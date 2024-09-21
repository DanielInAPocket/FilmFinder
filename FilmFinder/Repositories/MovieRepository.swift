//
//  MovieRepository.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation
import Factory

protocol MovieRepository {
    func getMovies(forList list: ListType, page: Int) async -> RepositoryResult<MoviePage>
    func getDetails(forMovieId movieId: Int) async -> RepositoryResult<MovieDetails>
    func search(for movieName: String, page: Int) async -> RepositoryResult<MoviePage>
}

class MovieRepositoryImplementation: MovieRepository {
    
    @Injected(\.movieAPIService) private var apiService
    @Injected(\.listStorage) private var listStorage
    @Injected(\.movieStorage) private var movieStorage
    @Injected(\.movieDetailsStorage) private var movieDetailsStorage
    
    func getMovies(forList list: ListType, page: Int) async -> RepositoryResult<MoviePage> {
        do {
            let moviePage = try await tryFetchAndSaveMovies(forList: list, page: page)
            return .latest(data: moviePage)
        } catch {
            do {
                let moviePage = try tryLoadingCachedMovies(forList: list)
                return .fallback(data: moviePage, error: error)
            } catch {
                return .failure(error: error)
            }
        }
    }

    func getDetails(forMovieId movieId: Int) async -> RepositoryResult<MovieDetails> {
        do {
            let movieDetails = try tryLoadingCachedMovieDetails(forId: movieId)
            return .latest(data: movieDetails)
        } catch {
            do {
                let movieDetails = try await tryFetchAndSaveMovieDetails(forId: movieId)
                return .latest(data: movieDetails)
            } catch {
                return .failure(error: error)
            }
        }
    }
    
    func search(for movieName: String, page: Int) async -> RepositoryResult<MoviePage> {
        do {
            let movieDetails = try await tryFetchSearchedMovies(withName: movieName, page: page)
            return .latest(data: movieDetails)
        } catch {
            return .failure(error: error)
        }
    }
}

private extension MovieRepositoryImplementation {
    
    // MARK: - Movie lists
    
    func tryFetchAndSaveMovies(forList list: ListType, page: Int) async throws -> MoviePage {
        let moviePageDTO = try await apiService.getMovies(forList: list, page: page)
        var moviePage = MovieMapper.mapToDomain(moviePageDTO)

        try movieStorage.save(contentsOf: moviePage.movies.map { MovieMapper.mapToDAO($0) })

        if page == 1 {
            try listStorage.override(.init(type: list.rawValue, movieIds: moviePage.movies.map { $0.id }))
        } else {
            // NOTE: Sometimes API returns same movie on different pages.
            // 1. Getting saved movie IDs for current list
            // 2. Filtering fetched movies
            // 3. Saving unique movies
            // 4. Rebuilding movie page data
            let savedList = try listStorage.loadBy(type: list)
            let filteredMovies = moviePage.movies.filter { !savedList.movieIds.contains($0.id) }
            try listStorage.append(.init(type: list.rawValue, movieIds: filteredMovies.map { $0.id }))
            moviePage = MoviePage(page: moviePage.page, movies: filteredMovies, totalPages: moviePage.totalPages)
        }

        return moviePage
    }
    
    func tryLoadingCachedMovies(forList list: ListType) throws -> MoviePage {
        let listDAO = try listStorage.loadBy(type: list)
        let movieDAOs = try movieStorage.loadByIds(Array(listDAO.movieIds))
        let movies = movieDAOs.map { MovieMapper.mapToDomain($0) }
        return MoviePage(page: 1, movies: movies, totalPages: 1)
    }
    
    // MARK: - Movie details
    
    func tryLoadingCachedMovieDetails(forId id: Int) throws -> MovieDetails {
        let movieDetailsDAO = try movieDetailsStorage.loadById(id)
        let movieDetails = MovieDetailsMapper.mapToDomain(movieDetailsDAO)
        return movieDetails
    }

    func tryFetchAndSaveMovieDetails(forId id: Int) async throws -> MovieDetails {
        let movieDTO = try await apiService.getMovieDetails(forId: id)
        
        // NOTE: For some API can return duplicates in Actors collection.
        // Filtering duplicates based on PersonDTO.id property
        let actors = movieDTO.credits?.cast.filterDuplicates(includeElement: { $0.id == $1.id }) ?? []
        let movieDetails = MovieDetailsMapper.mapToDomain(movieDTO, actors: actors)
        let movieDetailsDAO = MovieDetailsMapper.mapToDAO(movieDetails)
        try movieDetailsStorage.save(movieDetailsDAO)
        return movieDetails
    }
    
    // MARK: - Search
    
    func tryFetchSearchedMovies(withName name: String, page: Int) async throws -> MoviePage {
        let moviePageDTO = try await apiService.searchMovies(withName: name, page: page)
        let moviePage = MovieMapper.mapToDomain(moviePageDTO)
        return moviePage
    }
}
