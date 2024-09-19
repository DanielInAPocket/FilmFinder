//
//  MovieRequest.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation

enum MovieRequest: HTTPRequest {
    case getTrending(page: Int)
    case getMovieDetails(id: Int)
    
    var path: String {
        switch self {
        case .getTrending:
            return "trending/movie/day"
        case .getMovieDetails(let id):
            return "movie/\(id)"
        }
    }
    
    var queryParams: [String: Any]? {
        switch self {
        case .getTrending(let page):
            return ["page": page]
        case .getMovieDetails:
            return ["append_to_response": "credits"]
        }
    }
        
    var method: HTTPMethod {
        switch self {
        case .getTrending:
            return .get
        case .getMovieDetails:
            return .get
        }
    }
}
