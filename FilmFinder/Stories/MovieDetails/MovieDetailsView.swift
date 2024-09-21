//
//  MovieDetailsView.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import SwiftUI
import Factory

struct MovieDetailsView: View {
    
    @StateObject private var viewModel: MovieDetailsViewModel

    init(movie: Movie) {
        self._viewModel = StateObject(
            wrappedValue: MovieDetailsViewModel(movie: movie)
        )
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 12) {
                header
                
                detailsRow
                    .padding()

                Text(Strings.movieDetailsStoryline)
                    .style(.detailTitle)
                    .padding(.horizontal)

                Text(viewModel.state.details.overview)
                    .style(.details)
                    .padding(.horizontal)

                Text(Strings.movieDetailsCast)
                    .style(.detailTitle)
                    .padding(.horizontal)

                castSlider
            }
            .padding(.bottom)
        }
        .navigationBarTitle("", displayMode: .inline)
        .task {
            await viewModel.performAction(.initialize)
        }
        .background(Colors.background.color)
    }
    
    @ViewBuilder
    private var header: some View {
        VStack(spacing: 8) {
//                AsyncButton(
//                    action: {
//                        await viewModel.performAction(.toggleWatchlist)
//                    },
//                    label: {
//                        Image(systemSymbol: .heart)
//                            .foregroundColor(Colors.Button.buttonForeground.color)
//                            .frame(width: 40, height: 40)
//                            .background(Colors.Button.buttonBackground.color)
//                            .clipShape(.rect(cornerRadius: 20))
//                    }
//                )

            HStack {
                Spacer()
                
                CachedAsyncImage(url: viewModel.state.movie.posterUrl)
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.size.width * 0.55)
                    .clipShape(.rect(cornerRadius: 16))

                Spacer()
            }
            .padding(.bottom)
            
            Text(viewModel.state.movie.title)
                .style(.movieTitle)
            
            Text("\(String(format: "%.1f", viewModel.state.movie.rating))")
                .style(.movieRating)
                .padding(.bottom, 4)

            RatingView(
                rating: viewModel.state.movie.rating,
                spacing: 8
            )
            .frame(height: 14)
        }
    }

    @ViewBuilder
    private var detailsRow: some View {
        HStack {
            details(
                title: Strings.movieDetailsLength,
                value: String(viewModel.state.details.runtime)
            )
            Spacer()
            details(
                title: Strings.movieDetailsCountry,
                value: viewModel.state.details.originCountry
            )
            Spacer()
            details(
                title: Strings.movieDetailsYear,
                value: viewModel.state.details.releaseYear
            )
            Spacer()
            details(
                title: Strings.movieDetailsPopularity,
                value: String(format: "%.1f", viewModel.state.details.popularity)
            )
        }
    }
    
    @ViewBuilder
    private func details(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .style(.detailName)
            
            if viewModel.state.isLoading {
                ProgressView()
            } else {
                Text(value)
                    .style(.detailValue)
            }
        }
    }

    @ViewBuilder
    private var castSlider: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                ForEach(viewModel.state.details.actors) { actor in
                    ActorView(actor: actor)
                }
            }
            .padding(.horizontal)
        }
    }
}
