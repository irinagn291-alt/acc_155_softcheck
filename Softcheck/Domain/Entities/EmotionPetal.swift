import SwiftUI

/// One of the eight petals of the mood-wheel. Petals are broad emotion
/// families; tapping one reveals its finer-grained `EmotionShade` options.
enum EmotionPetal: String, CaseIterable, Codable, Identifiable, Sendable {
    case joyful
    case calm
    case sad
    case anxious
    case angry
    case tired
    case lonely
    case overwhelmed

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .joyful: return "Joy"
        case .calm: return "Calm"
        case .sad: return "Sadness"
        case .anxious: return "Anxiety"
        case .angry: return "Anger"
        case .tired: return "Tiredness"
        case .lonely: return "Loneliness"
        case .overwhelmed: return "Overwhelm"
        }
    }

    /// Soft, muted tint for the petal — never a "bad/good" red-green scale.
    var tint: Color {
        switch self {
        case .joyful: return Color(hex: "#FFC2D1")
        case .calm: return Color(hex: "#B8C0FF")
        case .sad: return Color(hex: "#A7B4D6")
        case .anxious: return Color(hex: "#C9A7E0")
        case .angry: return Color(hex: "#E3A7A0")
        case .tired: return Color(hex: "#C7B7A3")
        case .lonely: return Color(hex: "#9FB8C9")
        case .overwhelmed: return Color(hex: "#9D8DF1")
        }
    }

    /// Finer-grained shades belonging to this petal, in display order.
    var shades: [EmotionShade] {
        EmotionShade.all.filter { $0.petal == self }
    }

    /// Thin, rounded SF Symbol used inside the petal — never a face/emoji
    /// that could read as a good/bad judgment.
    var symbolName: String {
        switch self {
        case .joyful: return "sun.max"
        case .calm: return "leaf"
        case .sad: return "cloud.rain"
        case .anxious: return "wind"
        case .angry: return "flame"
        case .tired: return "moon.zzz"
        case .lonely: return "figure.stand"
        case .overwhelmed: return "tornado"
        }
    }
}
