import Foundation

/// Broad family a `Practice` belongs to — drives the icon shown in the UI.
enum PracticeCategory: String, CaseIterable, Codable, Sendable {
    case breathing
    case grounding
    case journaling
    case movement
    case connection
    case rest
    case senses

    var symbolName: String {
        switch self {
        case .breathing: return "wind"
        case .grounding: return "leaf"
        case .journaling: return "pencil.and.scribble"
        case .movement: return "figure.walk"
        case .connection: return "heart.text.square"
        case .rest: return "moon.zzz"
        case .senses: return "hand.raised"
        }
    }
}
