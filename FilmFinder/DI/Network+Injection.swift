//
//  Network+Injections.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation
import Factory

public extension Container {
    
    internal var networkDispatcher: Factory<NetworkDispatcher> {
        self { NetworkDispatcherImplementation() }
    }

    internal var responseParser: Factory<ResponseParser> {
        self { ResponseParserImplementation() }
    }

    internal var requestFactory: Factory<RequestFactory> {
        self { RequestFactoryImplementation() }
    }

    internal var errorFactory: Factory<NetworkErrorFactory> {
        self { NetworkErrorFactoryImplementation(responseParser: self.responseParser()) }
    }
    
    internal var movieAPIService: Factory<MovieAPIService> {
        self { MovieAPIServiceImplementation(dispatcher: self.networkDispatcher()) }
    }
}
