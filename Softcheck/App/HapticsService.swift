import UIKit

/// Stateless haptics helper. The only intentional "singleton-like" type in the app,
/// since haptic generators are cheap, side-effect-free wrappers around system feedback.
enum HapticsService {
    /// Fired the moment a petal is tapped and the shade picker opens.
    static func petalOpened() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }

    /// Fired the moment a shade is chosen and the matched practice is revealed —
    /// the app's gentle "moment of outcome".
    static func practiceRevealed() {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
    }

    /// Fired for destructive/confirming actions in Settings (e.g. reset).
    static func warning() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
}
