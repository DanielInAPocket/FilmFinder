//
//  ContentView.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import SwiftUI
import SFSafeSymbols

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemSymbol: .globe)
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
