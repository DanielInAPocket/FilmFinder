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
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                header()
                
                detailsRow()
                    .padding(.vertical)
                
                Text("Storyline") // TODO: Localize
                    .style(.detailTitle)
                
                Text(viewModel.state.details.overview)
                    .style(.details)

                Text("Cast") // TODO: Localize
                    .style(.detailTitle)
                
                castSlider()
            }
            .padding(.horizontal)
        }
        .task {
            await viewModel.performAction(.initialize)
        }
        .navigationBarHidden(true)
        .background(Colors.background.color)
    }
    
    @ViewBuilder
    private func header() -> some View {
        VStack(spacing: 8) {
            HStack {
                AsyncButton(
                    action: {
                        await viewModel.performAction(.pop)
                    },
                    label: {
                        Image(systemSymbol: .arrowBackward)
                            .foregroundColor(Colors.Button.buttonForeground.color)
                            .frame(width: 40, height: 40)
                            .background(Colors.Button.buttonBackground.color)
                            .clipShape(.rect(cornerRadius: 20))
                    }
                )
                
                Spacer()
                
                AsyncButton(
                    action: {
                        await viewModel.performAction(.toggleWatchlist)
                    },
                    label: {
                        Image(systemSymbol: .heart)
                            .foregroundColor(Colors.Button.buttonForeground.color)
                            .frame(width: 40, height: 40)
                            .background(Colors.Button.buttonBackground.color)
                            .clipShape(.rect(cornerRadius: 20))
                    }
                )
            }
            
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
    private func detailsRow() -> some View {
        HStack {
            details(
                title: "Length", // TODO: Localize
                value: String(viewModel.state.details.runtime)
            )
            Spacer()
            details(
                title: "Country", // TODO: Localize
                value: viewModel.state.details.originCountry
             )
            Spacer()
            details(
                title: "Year", // TODO: Localize
                value: viewModel.state.details.releaseDate
            )
            Spacer()
            details(
                title: "Popularity", // TODO: Localize
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
    private func castSlider() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                ForEach(viewModel.state.details.actors) { actor in
                    ActorView(actor: actor)
                }
            }
        }
    }
}
