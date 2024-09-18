//
//  ResponseParser.swift
//  Countries
//
//  Created by Daniel Klinge on 16/09/2024.
//

import Foundation

protocol ResponseParser {
    func parseDataToModel<Model: Decodable>(data: Data) throws -> Model
}

final class ResponseParserImplementation: ResponseParser {

    private let decoder = JSONDecoder()
    
    func parseDataToModel<Model: Decodable>(data: Data) throws -> Model {
        do {
            return try decoder.decode(Model.self, from: data)
        } catch {
            #if DEBUG
            print("❌ Failed to decode \"\(String(describing: Model.self))\" from JSON:\n\(error)")
            #endif
            
            throw error
        }
    }
}
