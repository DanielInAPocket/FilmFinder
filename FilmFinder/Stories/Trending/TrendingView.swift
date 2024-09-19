//
//  TrendingView.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 17/09/2024.
//

import SwiftUI
import Factory

struct TrendingView: View {
    
    @StateObject private var viewModel = TrendingViewModel()
    @ObservedObject var navigationState = Container.shared.trendingNavigationState()
    
    var body: some View {
        NavigationStack(path: $navigationState.routes) {
            rootView
                .navigationDestination(for: TrendingRoute.self) { $0 }
        }
    }
    
    @ViewBuilder private var rootView: some View {
        ScrollView(showsIndicators: false) {
            HStack(spacing: 0) {
                Text(Strings.trendingHeadline)
                    .style(.headline)
                Spacer()
            }

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
                    LoaderCardView()
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
        .background(Colors.background.color)
    }
    
    private let columns = [
        GridItem(.flexible(), spacing: 16, alignment: .top),
        GridItem(.flexible(), spacing: 16, alignment: .top)
    ]
}
