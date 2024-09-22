//
//  BaseRouter.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 22/09/2024.
//

import Foundation
import Combine
import SwiftUI

class BaseNavigationState<T: BaseRoute>: ObservableObject {
    @Published var routes: [T] = []
    @Published var toast: Toast?
}

@MainActor
class BaseRouter<T: BaseRoute> {
    
    private var navigationState: BaseNavigationState<T>
    
    init(navigationState: BaseNavigationState<T>) {
        self.navigationState = navigationState
    }
    
    func presentRoute(_ route: T) {
        navigationState.routes.append(route)
    }
    
    func popToRoot() {
        navigationState.routes = []
    }
    
    func show(toast: Toast) {
        withAnimation {
            navigationState.toast = toast
        }
    }
}
