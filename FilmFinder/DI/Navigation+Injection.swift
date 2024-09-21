//
//  Navigation+Extension.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import Foundation
import Factory

extension Container {
    
    @MainActor var homeRouter: Factory<HomeRouter> {
        self { HomeRouter() }
            .singleton
    }
    
    @MainActor var searchRouter: Factory<SearchRouter> {
        self { SearchRouter() }
            .singleton
    }
    
    var homeNavigationState: Factory<HomeNavigationState> {
        self { HomeNavigationState() }
            .singleton
    }
    
    var searchNavigationState: Factory<SearchNavigationState> {
        self { SearchNavigationState() }
            .singleton
    }
}
