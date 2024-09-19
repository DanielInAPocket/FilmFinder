//
//  BaseViewModel.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class BaseViewModel<A: BaseViewAction, S: BaseViewState>: ObservableObject {
    
    @Published var state: S
    
    var cancellableBag = Set<AnyCancellable>()

    init(state: S) {
        self.state = state
    }

    func performAction(_ action: A) async { }
}
