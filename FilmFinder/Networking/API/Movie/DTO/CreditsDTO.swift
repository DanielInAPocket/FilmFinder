//
//  CreditsDTO.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import Foundation

struct CreditsDTO: Decodable {
    let cast: [PersonDTO]
    let crew: [PersonDTO]
}
