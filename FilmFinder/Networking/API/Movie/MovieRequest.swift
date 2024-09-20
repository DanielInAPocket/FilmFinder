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
        }
    }
}
