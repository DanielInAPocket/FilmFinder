//
//  MainViewModel.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 21/09/2024.
//

import Foundation
import Factory

// MARK: - Action

enum MainViewAction: BaseViewAction {
    case tabClicked(ApplicationTab)
}

// MARK: - State

struct MainViewState: BaseViewState {
    var selectedTab = ApplicationTab.home
}

// MARK: - Model

class MainViewModel: BaseViewModel<MainViewAction, MainViewState> {
    
    @Injected(\.homeRouter) private var homeRouter
    @Injected(\.searchRouter) private var searchRouter
    
    init() {
        super.init(state: .init())
    }
    
    override func performAction(_ action: MainViewAction) async {
        switch action {
        case .tabClicked(let tab):
            onTabClick(tab)
        }
    }
}

private extension MainViewModel {
    
    func onTabClick(_ tab: ApplicationTab) {
        if state.selectedTab == tab {
            onTabReclick(tab)
        } else {
            state.selectedTab = tab
        }
    }
    
    func onTabReclick(_ tab: ApplicationTab) {
        switch tab {
        case .home:
            homeRouter.popToRoot()
        case .search:
            searchRouter.popToRoot()
        case .watchList:
            break
        }
    }
}
