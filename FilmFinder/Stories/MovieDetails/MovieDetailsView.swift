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
                
                Text(viewModel.state.movie.overview)
                    .style(.details)

                Text("Cast") // TODO: Localize
                    .style(.detailTitle)
            }
            .padding(.horizontal)
        }
        .background(Colors.background.color)
    }
    
    @ViewBuilder
    private func header() -> some View {
        VStack(spacing: 8) {
            HStack {
                Spacer()
                
                CachedAsyncImage(
                    url: URL(string: "https://image.tmdb.org/t/p/original/\(viewModel.state.movie.posterPath ?? "")")
                )
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
            details(title: "Length", value: "02:24:46") // TODO: Localize and provide data
            Spacer()
            details(title: "Language", value: "English") // TODO: Localize and provide data
            Spacer()
            details(title: "Year", value: "2015") // TODO: Localize and provide data
            Spacer()
            details(title: "Rating", value: "+28") // TODO: Localize and provide data
        }
    }
    
    @ViewBuilder
    private func details(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .style(.detailName)
            
            Text(value)
                .style(.detailValue)
        }
    }
}
