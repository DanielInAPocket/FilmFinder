//
//  Toast.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 21/09/2024.
//

import SwiftUI
import SFSafeSymbols

enum Toast: Equatable {
    case error(title: String, subtitle: String? = nil)
    case warning(title: String, subtitle: String? = nil)

    var title: String {
        switch self {
        case .error(let title, _),
                .warning(let title, _):
            return title
        }
    }

    var subtitle: String? {
        switch self {
        case .error(_, let subtitle),
                .warning(_, let subtitle):
            return subtitle
        }
    }

    var duration: TimeInterval {
        return 5.0
    }
}

extension Toast {
    
    static var cacheWarning: Toast {
        return .warning(title: Strings.toastWarningTitle, subtitle: Strings.toastCacheMessage)
    }

    static func error(from error: Error) -> Toast {
        return .error(title: Strings.toastErrorTitle, subtitle: error.localizedDescription)
    }
}
