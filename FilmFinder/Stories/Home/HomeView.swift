//
//  HomeView.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 17/09/2024.
//

import SwiftUI
import Factory

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    @ObservedObject var navigationState = Container.shared.trendingNavigationState()
    
    var body: some View {
        NavigationStack(path: $navigationState.routes) {
            rootView
                .navigationDestination(for: TrendingRoute.self) { $0 }
        }
    }
    
    @ViewBuilder private var rootView: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                section(title: "Now Playing", sectionState: viewModel.state.nowPlaying) // TODO: Localize
                section(title: "Popular", sectionState: viewModel.state.popular) // TODO: Localize
                section(title: "Trending", sectionState: viewModel.state.trending) // TODO: Localize
            }
        }
        .safeAreaPadding(.top)
        .background(Colors.background.color)
    }
    
    @ViewBuilder
    private func section(title: String, sectionState: SectionState) -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Text(title)
                    .style(.sectionTitle)
                Spacer()
            }
            .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top) {
                    ForEach(sectionState.movies) { movie in
                        MovieCardView(
                            movie: movie,
                            onTap: { movie in
                                await viewModel.performAction(.presentMovieDetails(movie))
                            }
                        )
                    }
                    
                    if sectionState.hasNextPage {
                        MovieCardView(
                            movie: .empty,
                            onTap: { _ in }
                        )
                        .redacted(reason: .placeholder)
                        .shimmering()
                        .onAppear {
                            Task {
                                await viewModel.performAction(.loadNextPage(forList: sectionState.listType))
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
