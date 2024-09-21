//
//  MainView.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = MainViewModel()
    
    @MainActor private var binding: Binding<ApplicationTab> {
        .init {
            viewModel.state.selectedTab
        } set: { tab in
            Task {
                await viewModel.performAction(.tabClicked(tab))
            }
        }
    }

    var body: some View {
        TabView(selection: binding) {
            ForEach(ApplicationTab.allCases, id: \.self) { tab in
                tabView(for: tab)
                    .tabItem {
                        Image(systemSymbol: tab.symbol)
                        Text(tab.title)
                    }
                    .tag(tab)
                    .toolbarBackground(Colors.background.color, for: .tabBar)
                    .toolbarBackground(.visible, for: .tabBar)
            }
        }
        .accentColor(Colors.accent.color)
    }
    
    @ViewBuilder
    private func tabView(for tab: ApplicationTab) -> some View {
        switch tab {
        case .home:
            HomeView()
        case .search:
            SearchView()
        case .watchList:
            WatchListView()
        }
    }
}
