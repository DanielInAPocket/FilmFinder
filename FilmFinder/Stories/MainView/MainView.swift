//
//  MainView.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import SwiftUI
import SFSafeSymbols
struct MainView: View {
    
    @State private var selectedTab = ApplicationTab.trending

    var body: some View {
        TabView(
            selection: $selectedTab,
            content: {
                TrendingView()
                    .tabItem {
                        Image(systemSymbol: .chartLineUptrendXyaxis)
                        Text(Strings.bottomMenuTrendingTitle)
                    }
                    .tag(ApplicationTab.trending)
//                    .toolbarBackground(Colors.background.color, for: .tabBar) // TODO: What looks best?

                SearchView()
                    .tabItem {
                        Image(systemSymbol: .magnifyingglass)
                        Text(Strings.bottomMenuSearchTitle)
                    }
                    .tag(ApplicationTab.search)
//                    .toolbarBackground(Colors.background.color, for: .tabBar) // TODO: What looks best?

                WatchListView()
                    .tabItem {
                        Image(systemSymbol: .heart)
                        Text(Strings.bottomMenuWatchlistTitle)
                    }
                    .tag(ApplicationTab.watchList)
//                    .toolbarBackground(Colors.background.color, for: .tabBar) // TODO: What looks best?
            }
        )
        .accentColor(Color.red) // TODO: Adjust color
    }
}
