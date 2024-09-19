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

    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack(spacing: 0) {
                Text(Strings.trendingHeadline)
                    .style(.headline)
                Spacer()
            }

            LazyVGrid(columns: columns, spacing: 32) {
                ForEach(viewModel.state.movies) { movie in
                    MovieCardView(
                        posterUrlString: movie.posterPath,
                        title: movie.title,
                        rating: movie.rating
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
