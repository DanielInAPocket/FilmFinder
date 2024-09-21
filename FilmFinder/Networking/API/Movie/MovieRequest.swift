//
//  MovieRequest.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation

enum MovieRequest: HTTPRequest {
    case getNowPlaying(page: Int)
    case getPopular(page: Int)
    case getTrending(page: Int)
    case getMovieDetails(id: Int)
    case search(forName: String, page: Int)
    
    var path: String {
        switch self {
        case .getNowPlaying:
            return "movie/now_playing"
        case .getPopular:
            return "movie/popular"
        case .getTrending:
            return "trending/movie/day"
        case .getMovieDetails(let id):
            return "movie/\(id)"
        case .search:
            return "search/movie"
        }
    }
    
    var queryParams: [String: Any]? {
        switch self {
        case .getNowPlaying(let page):
            return ["page": page]
        case .getPopular(let page):
            return ["page": page]
        case .getTrending(let page):
            return ["page": page]
        case .getMovieDetails:
            return ["append_to_response": "credits"]
        case .search(let name, let page):
            return [
                "query": name,
                "page": page
            ]
        }
    }
        
    var method: HTTPMethod {
        switch self {
        case .getNowPlaying:
            return .get
        case .getPopular:
            return .get
        case .getTrending:
            return .get
        case .getMovieDetails:
            return .get
        case .search:
            return .get
        }
    }
}
