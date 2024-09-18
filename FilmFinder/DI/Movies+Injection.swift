//
//  Movies+Injection.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation
import Factory

public extension Container {
    
    internal var movieRepository: Factory<MovieRepository> {
        self { MovieRepositoryImplementation(apiService: self.movieAPIService()) }
            .singleton
    }
}
