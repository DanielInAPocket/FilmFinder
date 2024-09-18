//
//  NetworkError.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation

struct NetworkError: Error, Equatable {
    let errorType: NetworkErrorType
    let url: URL?
    let message: String?
    
    init(
        errorType: NetworkErrorType,
        url: URL? = nil,
        message: String? = nil
    ) {
        self.errorType = errorType
        self.url = url
        self.message = message
    }
}

enum NetworkErrorType {
    case createRequest
    case response

    case resourceNotFound
    case internalError
        
    case timedOut
    case noConnectionToHost
    case noInternetConnection
    
    case unknown
}
