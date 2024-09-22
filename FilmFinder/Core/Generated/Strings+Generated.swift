// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {
  /// Home
  public static let bottomMenuHomeTitle = Strings.tr("Localizable", "bottom_menu_home_title", fallback: "Home")
  /// Search
  public static let bottomMenuSearchTitle = Strings.tr("Localizable", "bottom_menu_search_title", fallback: "Search")
  /// Watchlist
  public static let bottomMenuWatchlistTitle = Strings.tr("Localizable", "bottom_menu_watchlist_title", fallback: "Watchlist")
  /// Home
  public static let homeNavigationTitle = Strings.tr("Localizable", "home_navigation_title", fallback: "Home")
  /// Now Playing
  public static let homeNowPlayingSectionTitle = Strings.tr("Localizable", "home_now_playing_section_title", fallback: "Now Playing")
  /// Popular
  public static let homePopularSectionTitle = Strings.tr("Localizable", "home_popular_section_title", fallback: "Popular")
  /// Trending
  public static let homeTrendingSectionTitle = Strings.tr("Localizable", "home_trending_section_title", fallback: "Trending")
  /// Cast
  public static let movieDetailsCast = Strings.tr("Localizable", "movie_details_cast", fallback: "Cast")
  /// Country
  public static let movieDetailsCountry = Strings.tr("Localizable", "movie_details_country", fallback: "Country")
  /// Length
  public static let movieDetailsLength = Strings.tr("Localizable", "movie_details_length", fallback: "Length")
  /// Popularity
  public static let movieDetailsPopularity = Strings.tr("Localizable", "movie_details_popularity", fallback: "Popularity")
  /// Storyline
  public static let movieDetailsStoryline = Strings.tr("Localizable", "movie_details_storyline", fallback: "Storyline")
  /// Year
  public static let movieDetailsYear = Strings.tr("Localizable", "movie_details_year", fallback: "Year")
  /// Search for your favorite movie
  public static let searchEmptyMessage = Strings.tr("Localizable", "search_empty_message", fallback: "Search for your favorite movie")
  /// Search
  public static let searchNavigationTitle = Strings.tr("Localizable", "search_navigation_title", fallback: "Search")
  /// Nothing was found
  public static let searchNotFoundMessage = Strings.tr("Localizable", "search_not_found_message", fallback: "Nothing was found")
  /// API request failed, using cache instead
  public static let toastCacheMessage = Strings.tr("Localizable", "toast_cache_message", fallback: "API request failed, using cache instead")
  /// Error
  public static let toastErrorTitle = Strings.tr("Localizable", "toast_error_title", fallback: "Error")
  /// No cached data found. API fetch requests can't be made.
  public static let toastNoCacheMessage = Strings.tr("Localizable", "toast_no_cache_message", fallback: "No cached data found. API fetch requests can't be made.")
  /// No internet connection
  public static let toastNoInternet = Strings.tr("Localizable", "toast_no_internet", fallback: "No internet connection")
  /// Search is only available while phone is connected to the internet
  public static let toastSearchUnavailableMessage = Strings.tr("Localizable", "toast_search_unavailable_message", fallback: "Search is only available while phone is connected to the internet")
  /// Warning
  public static let toastWarningTitle = Strings.tr("Localizable", "toast_warning_title", fallback: "Warning")
  /// Add movies to watchlist by pressing a button in movie details
  public static let watchlistEmptyMessage = Strings.tr("Localizable", "watchlist_empty_message", fallback: "Add movies to watchlist by pressing a button in movie details")
  /// Watchlist
  public static let watchlistNavigationTitle = Strings.tr("Localizable", "watchlist_navigation_title", fallback: "Watchlist")
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
