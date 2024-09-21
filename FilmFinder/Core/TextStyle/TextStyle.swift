//
//  TextStyle.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import SwiftUI

enum TextStyle: String, CaseIterable {
    case headline
    case sectionTitle
    case listTitle
    case movieTitle
    case movieRating
    case detailName
    case detailValue
    case detailTitle
    case details
    case searchPlaceholder
    case toastTitle
    case toastSubtitle
    
    private var size: CGFloat {
        switch self {
        case .headline: return 34
        case .sectionTitle: return 24
        case .listTitle: return 16
        case .movieTitle: return 24
        case .movieRating: return 34
        case .detailName: return 14
        case .detailValue: return 14
        case .detailTitle: return 18
        case .details: return 16
        case .searchPlaceholder: return 24
        case .toastTitle: return 16
        case .toastSubtitle: return 14
        }
    }
    
    private var weight: FontWeight {
        switch self {
        case .headline: return .bold
        case .sectionTitle: return .bold
        case .listTitle: return .medium
        case .movieTitle: return .heavy
        case .movieRating: return .heavy
        case .detailName: return .medium
        case .detailValue: return .medium
        case .detailTitle: return .heavy
        case .details: return .medium
        case .searchPlaceholder: return .medium
        case .toastTitle: return .medium
        case .toastSubtitle: return .regular
        }
    }
    
    private var colorAsset: ColorAsset {
        switch self {
        case .movieRating: return Colors.Text.textSecondary
        case .detailName: return Colors.Text.textSecondary
        case .details: return Colors.Text.textSecondary
        case .searchPlaceholder: return Colors.Text.textSecondary
        case .toastSubtitle: return Colors.Text.textSecondary
        default: return Colors.Text.textPrimary
        }
    }
    
    var font: Font {
        return Font.system(size: size).weight(weight.fontWeight)
    }
    
    var uiFont: UIFont {
        return UIFont.systemFont(ofSize: size, weight: weight.uiFontWeight)
    }

    var color: Color {
        colorAsset.color
    }
    
    var uiColor: UIColor {
        colorAsset.uiColor
    }
    
    var asAttributes: [NSAttributedString.Key: Any] {
        return [
            .font: self.uiFont,
            .foregroundColor: UIColor(self.color)
        ]
    }
}

// MARK: - Preview

@available(iOS 15.0, *)
struct NewTextStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(TextStyle.allCases, id: \.self) { style in
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        line.frame(width: 8)
                        
                        Text(style.rawValue)
                            .font(TextStyle.listTitle.font.monospaced())
                            .foregroundColor(.black.opacity(0.3))
                        
                        line
                    }
                    
                    Text("The quick brown fox jumps over the lazy dog")
                        .style(style)
                }
            }
        }
        .padding()
        .previewLayout(.fixed(width: 768, height: 1650))
    }
    
    static var line: some View {
        VStack { Divider() }
    }
}
