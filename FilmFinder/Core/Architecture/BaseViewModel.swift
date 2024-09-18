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
open class BaseViewModel<A: BaseViewAction, S: BaseViewState>: ObservableObject {
    
    @Published public var state: S
    
    public var cancellableBag = Set<AnyCancellable>()

    public init(state: S) {
        self.state = state
    }

    open func performAction(_ action: A) async { }
}
