//
//  TextStyle.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 18/09/2024.
//

import SwiftUI

public enum TextStyle: String, CaseIterable {
    case headline
    case movieTitle
    
    private var size: CGFloat {
        switch self {
        case .headline: return 34
        case .movieTitle: return 16
        }
    }
    
    private var weight: FontWeight {
        switch self {
        case .headline: return .bold
        case .movieTitle: return .medium
        }
    }
    
    private var colorAsset: ColorAsset {
        switch self {
        case .headline: return Colors.Text.textPrimary
        case .movieTitle: return Colors.Text.textPrimary
        default: return Colors.Text.textPrimary
        }
    }
    
    public var font: Font {
        return Font.system(size: size).weight(weight.fontWeight)
    }
    
    public var uiFont: UIFont {
        return UIFont.systemFont(ofSize: size, weight: weight.uiFontWeight)
    }

    public var color: Color {
        colorAsset.color
    }
    
    public var uiColor: UIColor {
        colorAsset.uiColor
    }
    
    public var asAttributes: [NSAttributedString.Key: Any] {
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
                            .font(TextStyle.movieTitle.font.monospaced())
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
