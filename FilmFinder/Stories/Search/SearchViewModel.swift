//
//  SearchViewModel.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 21/09/2024.
//

import Foundation
import Factory
import Combine

class SearchViewModel: BaseViewModel<SearchViewAction, SearchViewState> {
    
    @Injected(\.movieRepository) private var movieRepository
    @Injected(\.searchRouter) private var searchRouter
    
    private let querySubject = CurrentValueSubject<String?, Never>(nil)
    private var searchTask: Task<()?, Never>?

    init() {
        super.init(state: .init())
        setupBindigs()
    }
    
    override func performAction(_ action: SearchViewAction) async {
        switch action {
        case .searchQuery(let query):
            querySubject.send(query)
        case .loadNextPage:
            await loadNextPage()
        case .presentMovieDetails(let movie):
            searchRouter.showDetails(for: movie)
        }
    }
}

private extension SearchViewModel {
    
    func setupBindigs() {
        querySubject
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .compactMap { $0 }
            .sink { [weak self] query in
                self?.executeQuery(query)
            }
            .store(in: &cancellableBag)
    }

    func executeQuery(_ query: String) {
        searchTask?.cancel()
        searchTask = Task {
            await loadSearchPage(for: query)
        }
    }
    
    func loadSearchPage(for query: String) async {
        state.isLoading = true
        defer {
            state.isLoading = false
        }

        guard !query.isEmpty else {
            resetState()
            return
        }
        
        if query != state.searchedQuery {
            resetState()
        }

        let result = await movieRepository.search(
            for: query,
            page: state.page
        )
        
        if let moviePage = result.getData() {
            state.searchedQuery = query
            state.movies.append(contentsOf: moviePage.movies)
            state.page += 1
            state.availablePages = moviePage.totalPages
        }

        if let error = result.getError() {
            show(error: error)
        }
    }
    
    func loadNextPage() async {
        await loadSearchPage(for: state.searchedQuery)
    }
    
    func resetState() {
        state.movies = []
        state.page = 1
        state.availablePages = 0
        state.searchedQuery = ""
    }
    
    func show(error: Error) {
        print("TODO: Imeplement error handling") // TODO: Implement
    }
}
