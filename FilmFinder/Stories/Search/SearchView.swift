//
//  SearchView.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 17/09/2024.
//

import SwiftUI
import Factory
import SFSafeSymbols

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    @State private var searchText = ""

    @ObservedObject var navigationState = Container.shared.searchNavigationState()
    
    var body: some View {
        NavigationStack(path: $navigationState.routes) {
            rootView
                .background(Colors.background.color)
                .navigationTitle(Strings.searchNavigationTitle)
                .navigationDestination(for: SearchRoute.self) { $0 }
        }
        .searchable(text: $searchText)
        .autocorrectionDisabled(true)
        .onChange(of: searchText) { _, newValue in
            Task {
                await viewModel.performAction(.searchQuery(newValue))
            }
        }
    }
    
    @ViewBuilder 
    private var rootView: some View {
        if !viewModel.state.movies.isEmpty || viewModel.state.isLoading {
            results
        } else if !viewModel.state.searchedQuery.isEmpty && viewModel.state.movies.isEmpty {
            message(
                text: Strings.searchNotFoundMessage,
                icon: .questionmarkVideo
            )
        } else {
            message(
                text: Strings.searchEmptyMessage,
                icon: .magnifyingglass
            )
        }
    }
    
    @ViewBuilder 
    private func message(text: String, icon: SFSymbol) -> some View {
        VStack(spacing: 16) {
            Text(text)
                .style(.searchPlaceholder)
            
            Image(systemSymbol: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 35)
                .foregroundColor(Colors.Text.textSecondary.color)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    private var results: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 32) {
                ForEach(viewModel.state.movies) { movie in
                    MovieCardView(
                        movie: movie,
                        onTap: { movie in
                            await viewModel.performAction(.presentMovieDetails(movie))
                        }
                    )
                }
                
                if viewModel.state.hasNextPage {
                    MovieCardView(
                        movie: .empty,
                        onTap: { _ in }
                    )
                    .redacted(reason: .placeholder)
                    .shimmering()
                    .onAppear {
                        Task {
                            await viewModel.performAction(.loadNextPage)
                        }
                    }
                }
            }
            .padding(.bottom)
        }
        .safeAreaPadding(.top)
        .padding(.horizontal, 16)
    }
    
    private let columns = [
        GridItem(.flexible(), spacing: 16, alignment: .top),
        GridItem(.flexible(), spacing: 16, alignment: .top)
    ]
}
