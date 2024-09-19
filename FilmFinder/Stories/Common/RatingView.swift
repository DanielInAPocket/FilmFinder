//
//  RatingView.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import SwiftUI
import SFSafeSymbols

struct RatingView: View {
    var rating: CGFloat
    var starsCount = 5
    var maxRating = 10
    var spacing: CGFloat = 4
    
    var body: some View {
        let stars = HStack(spacing: spacing) {
            ForEach(0..<starsCount, id: \.self) { _ in
                Image(systemSymbol: .starFill)
                    .resizable()
                    .foregroundColor(Colors.Rating.star.color)
                    .aspectRatio(contentMode: .fit)
            }
        }

        stars.overlay(
            GeometryReader { reader in
                let width = rating / CGFloat(maxRating) * reader.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(Colors.Rating.starFilled.color)
                }
            }
            .mask(stars)
        )
        .foregroundColor(.gray)
    }
}

// MARK: - Preview

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            RatingView(rating: 0, starsCount: 10)
            RatingView(rating: 0.5)
            RatingView(rating: 7.4)
            RatingView(rating: 7.4, starsCount: 1)
        }
        .padding()
    }
}
