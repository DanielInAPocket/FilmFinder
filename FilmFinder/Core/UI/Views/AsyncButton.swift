//
//  AsyncButton.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 19/09/2024.
//

import SwiftUI

struct AsyncButton<Label: View>: View {
    
    private var action: () async -> Void
    private var label: Label
    
    @State private var isPerformingTask = false
    
    init(
        action: @escaping () async -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.action = action
        self.label = label()
    }

    var body: some View {
        Button(
            action: {
                isPerformingTask = true
            
                Task {
                    await action()
                    isPerformingTask = false
                }
            },
            label: {
                label
            }
        )
        .disabled(isPerformingTask)
    }
}

// MARK: - Preview

struct AsyncButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            AsyncButton(
                action: { },
                label: {
                    Text("Main Button")
                        .style(.listTitle)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 20)
                }
            )
            
            AsyncButton(
                action: { },
                label: {
                    Text("Main Button Disabled")
                        .style(.listTitle)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 20)
                }
            )
            .disabled(true)
        }
    }
}
