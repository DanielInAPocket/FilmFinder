//
//  MovieRequest.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation

enum MovieRequest: HTTPRequest {
    case getTrending(page: Int)
    
    var path: String {
        switch self {
        case .getTrending:
            return "trending/movie/day"
        }
    }
    
    var queryParams: [String: Any]? {
        switch self {
        case .getTrending(let page):
            return ["page": page]
        }
    }
        
    var method: HTTPMethod {
        switch self {
        case .getTrending:
            return .get
        }
    }
}
