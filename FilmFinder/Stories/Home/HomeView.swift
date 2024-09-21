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
    @ObservedObject var navigationState = Container.shared.homeNavigationState()
    
    var body: some View {
        NavigationStack(path: $navigationState.routes) {
            rootView
                .background(Colors.background.color)
                .navigationTitle(Strings.homeNavigationTitle)
                .navigationDestination(for: HomeRoute.self) { $0 }
        }
    }
    
    @ViewBuilder private var rootView: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                section(
                    title: Strings.homeNowPlayingSectionTitle,
                    sectionState: viewModel.state.nowPlaying
                )
                
                section(
                    title: Strings.homeTrendingSectionTitle,
                    sectionState: viewModel.state.popular
                )
                
                section(
                    title: Strings.homePopularSectionTitle,
                    sectionState: viewModel.state.trending
                )
            }
            .padding(.bottom)
        }
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
                        .frame(width: 130)
                    }
                    
                    if sectionState.hasNextPage {
                        MovieCardView(
                            movie: .empty,
                            onTap: { _ in }
                        )
                        .frame(width: 130)
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
