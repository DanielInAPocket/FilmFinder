//
//  WatchListView.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 17/09/2024.
//

import SwiftUI
import Factory
import SFSafeSymbols

struct WatchListView: View {
    
    @StateObject private var viewModel = WatchListViewModel()
    @ObservedObject var navigationState = Container.shared.watchlistNavigationState()
    
    var body: some View {
        NavigationStack(path: $navigationState.routes) {
            rootView
                .task {
                    await viewModel.performAction(.loadMovies)
                }
                .background(Colors.background.color)
                .navigationTitle(Strings.watchlistNavigationTitle)
                .navigationDestination(for: MovieRoute.self) { $0 }
        }
        .toast(
            isPresenting: .init(
                get: {
                    navigationState.toast != nil
                },
                set: { isPresting in
                    if isPresting == false {
                        navigationState.toast = nil
                    }
                }
            ),
            toast: navigationState.toast
        )
    }
    
    @ViewBuilder
    private var rootView: some View {
        if !viewModel.state.movies.isEmpty {
            movieList
        } else {
            message
        }
    }
    
    @ViewBuilder
    private var message: some View {
        VStack(spacing: 24) {
            Text(Strings.watchlistEmptyMessage)
                .style(.emptyScreenMessage)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 16) {
                Image(systemSymbol: .heart)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35)
                    .foregroundColor(Colors.Text.textSecondary.color)

                Image(systemSymbol: .arrowRight)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundColor(Colors.Text.textSecondary.color)

                Image(systemSymbol: .heartFill)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35)
                    .foregroundColor(Colors.Text.textSecondary.color)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(32)
    }
    
    @ViewBuilder
    private var movieList: some View {
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
