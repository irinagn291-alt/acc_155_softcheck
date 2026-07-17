import SwiftUI

/// User-selectable appearance, persisted via `UserDefaults`/`AppStorage`.
enum AppearanceMode: String, CaseIterable, Identifiable, Sendable {
    case system
    case light
    case dark

    var id: String { rawValue }

    var title: String {
        switch self {
        case .system: return "System"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }

    var colorScheme: ColorSchemeOverride {
        switch self {
        case .system: return .unspecified
        case .light: return .light
        case .dark: return .dark
        }
    }
}

/// Thin wrapper so the design layer doesn't depend directly on `SwiftUI.ColorScheme?`.
enum ColorSchemeOverride {
    case unspecified
    case light
    case dark

    var preferredColorScheme: ColorScheme? {
        switch self {
        case .unspecified: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}
