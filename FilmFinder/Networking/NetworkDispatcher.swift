//
//  NetworkDispatcher.swift
//  Countries
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation
import Factory

protocol NetworkDispatcher {
    func send(_ request: HTTPRequest) async throws
    func fetch<Model: Decodable>(with request: HTTPRequest) async throws -> Model
}

final class NetworkDispatcherImplementation: NetworkDispatcher {
    
    @Injected(\.responseParser) private var responseParser
    @Injected(\.requestFactory) private var requestFactory
    @Injected(\.errorFactory) private var errorFactory
    
    private let urlSession: URLSession

    init() {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 60.0
        sessionConfig.timeoutIntervalForResource = 60.0
        
        urlSession = URLSession(configuration: sessionConfig)
    }
    
    func send(_ request: HTTPRequest) async throws {
        try await performNetworkRequest(request)
    }
    
    func fetch<Model: Decodable>(with request: HTTPRequest) async throws -> Model {
        let (data, response) = try await performNetworkRequest(request)
        do {
            return try responseParser.parseDataToModel(data: data)
        } catch {
            throw errorFactory.makeNetworkError(data, response: response)
        }
    }
}

private extension NetworkDispatcherImplementation {
        
    @discardableResult func performNetworkRequest(_ httpRequest: HTTPRequest) async throws -> (Data, HTTPURLResponse) {
        let request = try requestFactory.makeURLRequest(for: httpRequest)

        do {
            let (data, response) = try await urlSession.data(for: request)
            let httpResponse = response as! HTTPURLResponse // swiftlint:disable:this force_cast

            switch httpResponse.statusCode {
            case 200..<300: return (data, httpResponse)
            default: throw errorFactory.makeNetworkError(data, response: httpResponse)
            }

        } catch let error as NetworkError {
            throw error
        } catch {
            throw errorFactory.makeNetworkError(from: error, request: request)
        }
    }
}
