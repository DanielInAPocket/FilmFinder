//
//  Network+Injections.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation
import Factory

extension Container {
    
    var networkDispatcher: Factory<NetworkDispatcher> {
        self { NetworkDispatcherImplementation() }
    }

    var responseParser: Factory<ResponseParser> {
        self { ResponseParserImplementation() }
    }

    var requestFactory: Factory<RequestFactory> {
        self { RequestFactoryImplementation() }
    }

    var errorFactory: Factory<NetworkErrorFactory> {
        self { NetworkErrorFactoryImplementation() }
    }
    
    var movieAPIService: Factory<MovieAPIService> {
        self { MovieAPIServiceImplementation() }
    }
}
