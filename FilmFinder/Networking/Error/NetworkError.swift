//
//  NetworkError.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation

public struct NetworkError: Error, Equatable {
    public let errorType: NetworkErrorType
    public let url: URL?
    public let message: String?
    
    public init(
        errorType: NetworkErrorType,
        url: URL? = nil,
        message: String? = nil
    ) {
        self.errorType = errorType
        self.url = url
        self.message = message
    }
}

public enum NetworkErrorType {
    case createRequest
    case response

    case resourceNotFound
    case internalError
        
    case timedOut
    case noConnectionToHost
    case noInternetConnection
    
    case unknown
}
