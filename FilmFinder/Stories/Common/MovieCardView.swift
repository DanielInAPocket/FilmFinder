//
//  MovieCardView.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import SwiftUI

struct MovieCardView: View {
    let movie: Movie
    let onTap: (Movie) async -> Void
    
    var body: some View {
        AsyncButton(
            action: {
                await onTap(movie)
            },
            label: {
                VStack(spacing: 8) {
                    CachedAsyncImage(url: movie.posterUrl)
                        .clipShape(.rect(cornerRadius: 16))
                        .padding(.bottom, 8)
                    
                    RatingView(rating: movie.rating)
                        .frame(height: 12)
                    
                    Text(movie.title)
                        .style(.listTitle)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .frame(height: 40, alignment: .top)
                }
            }
        )
    }
}
