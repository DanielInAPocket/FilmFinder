//
//  PersonDTO.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import Foundation

struct PersonDTO {
    let id: Int
    let name: String
    let profilePath: String?
}

extension PersonDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
    }
}
