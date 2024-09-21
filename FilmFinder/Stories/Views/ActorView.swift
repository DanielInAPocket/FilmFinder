//
//  ActorView.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import SwiftUI

struct ActorView: View {
    let actor: Person
    
    var body: some View {
        VStack(spacing: 4) {
            CachedAsyncImage(url: actor.profileUrl)
                .clipShape(.rect(cornerRadius: 16))
                .padding(.bottom, 8)
            
            Text(actor.name)
                .style(.listTitle)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
        .frame(width: 80)
    }
}
