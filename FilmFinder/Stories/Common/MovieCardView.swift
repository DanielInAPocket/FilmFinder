//
//  MovieCardView.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import SwiftUI
import NukeUI

struct MovieCardView: View {
    let posterUrlString: String?
    let title: String
    let rating: Double
    
    var body: some View {
        VStack(spacing: 4) {
            CachedAsyncImage(
                url: URL(string: "https://image.tmdb.org/t/p/w342/\(posterUrlString ?? "")")
            )
            .clipShape(.rect(cornerRadius: 16))
            .padding(.bottom, 8)
            
            Text(title)
                .style(.movieTitle)
            
            RatingView(rating: rating)
                .frame(height: 12)
        }
    }
}
