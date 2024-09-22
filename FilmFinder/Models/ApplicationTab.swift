//
//  ApplicationTab.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation
import SFSafeSymbols

enum ApplicationTab: Hashable, CaseIterable {
    case home
    case search
    case watchList
}

extension ApplicationTab {
    var title: String {
        switch self {
        case .home: Strings.bottomMenuHomeTitle
        case .search: Strings.bottomMenuSearchTitle
        case .watchList: Strings.bottomMenuWatchlistTitle
        }
    }
    
    var symbol: SFSymbol {
        switch self {
        case .home: .popcorn
        case .search: .magnifyingglass
        case .watchList: .heart
        }
    }
}
