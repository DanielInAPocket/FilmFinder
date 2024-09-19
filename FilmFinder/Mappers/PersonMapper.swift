//
//  PersonMapper.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import Foundation

struct PersonMapper {
    
    static func mapToDomain(_ dto: PersonDTO) -> Person {
        var profileUrl: URL?
        if let profilePath = dto.profilePath {
            profileUrl = URL(string: "https://image.tmdb.org/t/p/original/\(profilePath)")
        }
        
        return Person(
            id: dto.id,
            name: dto.name,
            profileUrl: profileUrl
        )
    }
    
    static func mapToDomain(_ dao: PersonDAO) -> Person {
        var profileUrl: URL?
        if let profileUrlString = dao.profileUrl {
            profileUrl = URL(string: profileUrlString)
        }
        
        return Person(
            id: dao.id,
            name: dao.name,
            profileUrl: profileUrl
        )
    }

    static func mapToDAO(_ model: Person) -> PersonDAO {
        PersonDAO(
            id: model.id,
            name: model.name,
            profileUrl: model.profileUrl?.absoluteString
        )
    }
}
