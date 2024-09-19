//
//  View+Extensions.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import SwiftUI

/// - See Also: [View Extensions for Better Code Readability](
///     https://swiftui-lab.com/view-extensions-for-better-code-readability/)
public extension View {

    /// Applies `modifier` if `condition` is `true`, otherwise `self` is returned.
    @ViewBuilder func modifier<M: ViewModifier>(
        if condition: @autoclosure () -> Bool,
        _ modifier: M
    ) -> some View {
        if condition() {
            self.modifier(modifier)
        } else {
            self
        }
    }

    /// If `condition` is `true`, applies `then` modifier, otherwise applies `else` modifier.
    @ViewBuilder func modifier<M1: ViewModifier, M2: ViewModifier>(
        if condition: @autoclosure () -> Bool,
        then trueModifier: M1,
        else falseModifier: M2
    ) -> some View {
        if condition() {
            self.modifier(trueModifier)
        } else {
            self.modifier(falseModifier)
        }
    }

    // MARK: - Conditional Transform

    /// Executes `transform` closure if `condition` is `true`, overwise `self` is returned.
    @ViewBuilder func modifier<V: View>(
        if condition: @autoclosure () -> Bool,
        _ transform: (Self) -> V
    ) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }

    /// Executes `transform` closure if `condition` is `true` and  `value` is not `nil`, overwise `self` is returned.
    /// - Parameters:
    ///   - condition: Condition to check. Default is `true`.
    ///   - value: Value to unwrap.
    ///   - transform: Transformations to apply if `condition` is met and `value` is not `nil`.
    @ViewBuilder func modifier<T, V: View>(
        if condition: @autoclosure () -> Bool = true,
        for value: T?,
        _ transform: (Self, T) -> V
    ) -> some View {
        if condition(), let value = value {
            transform(self, value)
        } else {
            self
        }
    }

    /// If `condition` is `true`, executes `then` closure, otherwise executes `else` closure.
    @ViewBuilder func modifier<V1: View, V2: View>(
        if condition: @autoclosure () -> Bool,
        then transformTrue: (Self) -> V1,
        else transformFalse: (Self) -> V2
    ) -> some View {
        if condition() {
            transformTrue(self)
        } else {
            transformFalse(self)
        }
    }

    /// Adds view to hierarchy only if `condition` is true.
    @ViewBuilder func when(_ condition: @autoclosure () -> Bool) -> some View {
        if condition() {
            self
        }
    }
    
    /// Adds view to hierarchy only if `condition` returns non-nil value.
    @ViewBuilder func whenNotNil(_ condition: @autoclosure () -> Any?) -> some View {
        if condition() != nil {
            self
        }
    }
}
