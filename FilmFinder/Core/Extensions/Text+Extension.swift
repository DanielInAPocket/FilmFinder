//
//  Text+Extension.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import SwiftUI

extension Text {
    func style(_ style: TextStyle) -> some View {
        font(style.font)
            .foregroundColor(style.color)
    }
}
