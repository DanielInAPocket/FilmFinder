// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
  import SwiftUI
#elseif os(tvOS) || os(watchOS)
  import UIKit
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

public typealias Colors = ColorAsset

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public extension ColorAsset {
  static let accent = ColorAsset(name: "Accent")
  static let background = ColorAsset(name: "Background")
  enum Button {
    static let buttonBackground = ColorAsset(name: "ButtonBackground")
    static let buttonForeground = ColorAsset(name: "ButtonForeground")
  }
  static let foreground = ColorAsset(name: "Foreground")
  enum Rating {
    static let star = ColorAsset(name: "Star")
    static let starFilled = ColorAsset(name: "StarFilled")
  }
  enum System {
    static let caution = ColorAsset(name: "Caution")
    static let success = ColorAsset(name: "Success")
    static let warning = ColorAsset(name: "Warning")
  }
  enum Text {
    static let textPrimary = ColorAsset(name: "TextPrimary")
    static let textSecondary = ColorAsset(name: "TextSecondary")
    static let textTertiary = ColorAsset(name: "TextTertiary")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  typealias Color = UIColor
  #endif

  @available(iOS 1.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var uiColor: UIColor = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  @available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
  public var color: SwiftUI.Color {
    return .init(uiColor)
  }

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
