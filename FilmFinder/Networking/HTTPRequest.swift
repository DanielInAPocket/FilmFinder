//
//  HTTPRequest.swift
//  Countries
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum HTTPHeaderKey: String {
    case accept = "Accept"
    case contentType = "Content-Type"
}

enum HTTPHeaderValue: String {
    case appJson = "application/json"
}

enum APIVersion: String {
    case version3 = "3"
}

protocol HTTPRequest {
    var host: String? { get }
    var path: String { get }
    var apiVersion: APIVersion { get }
    var method: HTTPMethod { get }
    var bodyParams: [String: Any]? { get }
    var queryParams: [String: Any]? { get }
    var headers: [String: String]? { get }
}

extension HTTPRequest {
    public var host: String? { return nil }
    public var apiVersion: APIVersion { .version3 }
    public var method: HTTPMethod { .get }
    public var bodyParams: [String: Any]? { nil }
    public var queryParams: [String: Any]? { nil }
    public var headers: [String: String]? { nil }
}
