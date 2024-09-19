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
                VStack(spacing: 4) {
                    CachedAsyncImage(url: movie.posterUrl)
                        .clipShape(.rect(cornerRadius: 16))
                        .padding(.bottom, 8)
                    
                    Text(movie.title)
                        .style(.listTitle)
                        .multilineTextAlignment(.center)
                    
                    RatingView(rating: movie.rating)
                        .frame(height: 12)
                }
            }
        )
    }
}
