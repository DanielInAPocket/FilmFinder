//
//  ToastView.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 21/09/2024.
//

import SwiftUI
import SFSafeSymbols

struct ToastView: View {
    @State private var isPresented = false
    private let toast: Toast

    init(for toast: Toast) {
        self.toast = toast
    }

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            toastImage()
            VStack(alignment: .leading, spacing: 4) {
                Text(toast.title)
                    .foregroundColor(Colors.Text.textPrimary.color)
                    .style(.toastTitle)

                if let subtitle = toast.subtitle {
                    Text(subtitle)
                        .foregroundColor(Colors.Text.textSecondary.color)
                        .style(.toastSubtitle)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 28, alignment: .leading)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 18)
        .background(Colors.foreground.color.cornerRadius(8))
        .shadow(color: .black.opacity(0.2), radius: 15, y: 3)
    }
}

private extension ToastView {

    func toastImage() -> some View {
        let symbol: SFSymbol
        switch toast {
        case .error:
            symbol = .exclamationmarkCircle
        case .warning:
            symbol = .exclamationmarkTriangle
        }

        return Image(systemSymbol: symbol)
            .foregroundColor(iconColor)
            .font(.system(size: 20))
            .padding(.top, 2)
    }

    var iconColor: Color {
        switch toast {
        case .warning:
            return Colors.System.caution.color
        case .error:
            return Colors.System.warning.color
        }
    }
}
