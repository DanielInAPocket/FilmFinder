//
//  UIDevice+Extensions.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 16/09/2024.
//

import UIKit

extension UIDevice {
        
    /// Tells if app is currently running in XCTest mode.
    /// - See Also: [Check if app is running Unit Tests the Swift way](
    ///     https://medium.com/@theinkedengineer/check-if-app-is-running-unit-tests-the-swift-way-b51fbfd07989)
    static var isUnitTest: Bool {
        Thread.current.threadDictionary.allKeys
            .compactMap { $0 as? String }
            .map { $0.lowercased() }
            .contains { $0.contains(".xctest.") }
    }
    
    /// Tells if app is currently running in SwiftUI preview mode.
    /// - See Also: [StackOverflow](https://stackoverflow.com/a/61741858/944839)
    static var isSwiftUIPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
