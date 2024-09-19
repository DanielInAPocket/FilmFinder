//
//  Array+Extensions.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import Foundation

extension Array {
    func filterDuplicates(includeElement: (_ lhs: Element, _ rhs: Element) -> Bool) -> [Element] {
        var results = [Element]()

        forEach { (element) in
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            if existingElements.isEmpty {
                results.append(element)
            }
        }

        return results
    }
}
