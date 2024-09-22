//
//  Movies+Injection.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation
import Factory

extension Container {
    
    var movieRepository: Factory<MovieRepository> {
        self { MovieRepositoryImplementation() }
            .singleton
    }
}
