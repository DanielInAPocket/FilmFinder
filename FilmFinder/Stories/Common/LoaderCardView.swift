//
//  LoaderCardView.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import SwiftUI
import NukeUI

struct LoaderCardView: View {    
    var body: some View {
        ProgressView()
            .padding(.vertical, 112)
            .frame(maxWidth: .infinity)
            .background(Colors.loaderBackground.color)
            .clipShape(.rect(cornerRadius: 16))
    }
}
