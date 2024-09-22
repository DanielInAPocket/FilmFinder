//
//  FilmFinderApp.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import SwiftUI
import Factory

@main
struct FilmFinderApp: App {
    
    @Injected(\.movieRepository) private var movieRepository
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .task {
                    if !UserDefaults.standard.bool(forKey: "launchedBefore") {
                        movieRepository.initStorage()
                        UserDefaults.standard.set(true, forKey: "launchedBefore")
                    }
                }
        }
    }
}
