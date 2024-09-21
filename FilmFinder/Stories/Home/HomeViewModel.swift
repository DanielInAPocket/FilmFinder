//
//  HomeViewModel.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import Foundation
import Factory

class HomeViewModel: BaseViewModel<HomeViewAction, HomeViewState> {
    
    @Injected(\.movieRepository) private var movieRepository
    @Injected(\.homeRouter) private var homeRouter
    
    init() {
        super.init(state: .init())
    }
    
    override func performAction(_ action: HomeViewAction) async {
        switch action {
        case .loadNextPage(let listType):
            await fetchPage(for: listType)
        case .presentMovieDetails(let movie):
            homeRouter.showDetails(for: movie)
        }
    }
}

private extension HomeViewModel {
    
    func fetchPage(for listType: ListType) async {   
        var listState = getSectionState(for: listType)
        
        guard listState.page <= listState.availablePages, !listState.isLoading else {
            return
        }
        
        listState.isLoading = true
        saveSectionState(listState, for: listType)
        defer {
            listState.isLoading = false
            saveSectionState(listState, for: listType)
        }

        let result = await movieRepository.getMovies(forList: listType, page: listState.page)
        
        if let moviePage = result.getData() {
            listState.movies.append(contentsOf: moviePage.movies)
            listState.page += 1
            listState.availablePages = moviePage.totalPages
            saveSectionState(listState, for: listType)
        }
        
        if let error = result.getError() {
            show(error: error)
        }
    }
    
    func getSectionState(for listType: ListType) -> SectionState {
        switch listType {
        case .nowPlaying: return state.nowPlaying
        case .popular: return state.popular
        case .trending: return state.trending
        }
    }
    
    func saveSectionState(_ sectionState: SectionState, for listType: ListType) {
        switch listType {
        case .nowPlaying: state.nowPlaying = sectionState
        case .popular: state.popular = sectionState
        case .trending: state.trending = sectionState
        }
    }
    
    func show(error: Error) {
        print("TODO: Imeplement error handling") // TODO: Implement
    }
}
