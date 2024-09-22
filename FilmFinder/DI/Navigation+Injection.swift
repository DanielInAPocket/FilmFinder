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
        self { HomeRouterImplementation(navigationState: self.homeNavigationState()) }
            .singleton
    }
    
    @MainActor var searchRouter: Factory<SearchRouter> {
        self { SearchRouterImplementation(navigationState: self.searchNavigationState()) }
            .singleton
    }
    
    @MainActor var watchlistRouter: Factory<WatchlistRouter> {
        self { WatchlistRouterImplementation(navigationState: self.watchlistNavigationState()) }
            .singleton
    }
    
    var homeNavigationState: Factory<BaseNavigationState<MovieRoute>> {
        self { BaseNavigationState() }
            .singleton
    }
    
    var searchNavigationState: Factory<BaseNavigationState<MovieRoute>> {
        self { BaseNavigationState() }
            .singleton
    }
    
    var watchlistNavigationState: Factory<BaseNavigationState<MovieRoute>> {
        self { BaseNavigationState() }
            .singleton
    }
}
