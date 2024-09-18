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
                        Text("Trending") // TODO: Localize
                    }
                    .tag(ApplicationTab.trending)

                SearchView()
                    .tabItem {
                        Image(systemSymbol: .magnifyingglass)
                        Text("Search") // TODO: Localize
                    }
                    .tag(ApplicationTab.search)

                WatchListView()
                    .tabItem {
                        Image(systemSymbol: .heart)
                        Text("WatchList") // TODO: Localize
                    }
                    .tag(ApplicationTab.watchList)
            }
        )
        .accentColor(Color.red) // TODO: Adjust color
    }
}
