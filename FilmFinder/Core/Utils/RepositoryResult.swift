//
//  RepositoryResult.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation

public enum RepositoryResult<Data> {
    case latest(data: Data)
    case fallback(data: Data, error: Error)
    case failure(error: Error)
    
    public func getData() -> Data? {
        switch self {
        case .latest(let data), .fallback(let data, _):
            return data
        case .failure:
            return nil
        }
    }
    
    public func getError() -> Error? {
        switch self {
        case .failure(let error), .fallback(_, let error):
            return error
        case .latest:
            return nil
        }
    }
}
