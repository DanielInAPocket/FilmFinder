//
//  NetworkErrorFactory.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation
import Factory

protocol NetworkErrorFactory {
    func makeNetworkError(_ data: Data?, response: HTTPURLResponse) -> Error
    func makeNetworkError(from error: Error, request: URLRequest) -> Error
}

final class NetworkErrorFactoryImplementation: NetworkErrorFactory {
    
    @Injected(\.responseParser) private var responseParser
    
    func makeNetworkError(_ data: Data?, response: HTTPURLResponse) -> Error {
        switch response.statusCode {
        case 404:
            return NetworkError(errorType: .resourceNotFound, url: response.url!)
        case 500:
            return NetworkError(errorType: .internalError, url: response.url!)
        default:
            return NetworkError(errorType: .unknown, url: response.url!)
        }
    }
    
    func makeNetworkError(from error: Error, request: URLRequest) -> Error {
        switch (error as NSError).code {
        case NSURLErrorCannotConnectToHost:
            return NetworkError(errorType: .noConnectionToHost, url: request.url!)
        case NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet:
            return NetworkError(errorType: .noInternetConnection, url: request.url!)
        case NSURLErrorTimedOut:
            return NetworkError(errorType: .timedOut, url: request.url!)
        default:
            return NetworkError(errorType: .unknown, url: request.url!)
        }
    }
}
