// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {
  /// Search
  public static let bottomMenuSearchTitle = Strings.tr("Localizable", "bottom_menu_search_title", fallback: "Search")
  /// Trending
  public static let bottomMenuTrendingTitle = Strings.tr("Localizable", "bottom_menu_trending_title", fallback: "Trending")
  /// Watchlist
  public static let bottomMenuWatchlistTitle = Strings.tr("Localizable", "bottom_menu_watchlist_title", fallback: "Watchlist")
  /// Trending
  public static let trendingHeadline = Strings.tr("Localizable", "trending_headline", fallback: "Trending")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = key.localized(tableName: table, defaultValue: value)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    return Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type
