//
//  RequestFactory.swift
//  Countries
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation

protocol RequestFactory {
    func makeURLRequest(for request: HTTPRequest) throws -> URLRequest
}

final class RequestFactoryImplementation: RequestFactory {
        
    private var commonHeaders: [String: String] = [
        HTTPHeaderKey.contentType.rawValue: HTTPHeaderValue.appJson.rawValue,
        HTTPHeaderKey.accept.rawValue: HTTPHeaderValue.appJson.rawValue
    ]

    func makeURLRequest(for request: HTTPRequest) throws -> URLRequest {
        guard let url = makeURL(for: request) else {
            throw NetworkError(errorType: .createRequest)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        commonHeaders.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        return urlRequest
    }
    
    private func makeURL(for request: HTTPRequest) -> URL? {
        let urlString = request.host ?? NetworkConstants.baseUrl
        guard var url = URL(string: urlString) else {
            return nil
        }

        url.appendPathComponent(request.apiVersion.rawValue)
        url.appendPathComponent(request.path)

        if let queryParams = request.queryParams {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = queryParams.map { URLQueryItem(name: "\($0)", value: "\($1)") }
            if let newUrl = urlComponents?.url {
                url = newUrl
            }
        }
        
        // TODO: Find a better way to handle API key
        if urlString == NetworkConstants.baseUrl {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            
            if urlComponents?.queryItems == nil {
                urlComponents?.queryItems = []
            }
            
            urlComponents?.queryItems?.append( URLQueryItem(name: "api_key", value: NetworkConstants.apiKey))
            if let newUrl = urlComponents?.url {
                url = newUrl
            }
        }
        
        return url
    }
}
