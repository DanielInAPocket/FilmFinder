//
//  Navigation+Extension.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import Foundation
import Factory

extension Container {
    
    @MainActor var trendingRouter: Factory<TrendingRouter> {
        self { TrendingRouter() }
            .singleton
    }

    var trendingNavigationState: Factory<TrendingNavigationState> {
        self { TrendingNavigationState() }
            .singleton
    }
}
