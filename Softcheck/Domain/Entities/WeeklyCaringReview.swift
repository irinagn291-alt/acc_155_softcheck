import Foundation

/// A quiet, descriptive weekly summary — never a score, streak, or
/// good/bad verdict. Just a gentle reflection of what showed up.
struct WeeklyCaringReview: Equatable, Sendable {
    let checkInCount: Int
    let mostFrequentPetal: EmotionPetal?
    let distinctShadeCount: Int
    let mostUsedPractice: Practice?

    var hasEnoughDataToShow: Bool { checkInCount > 0 }

    var careNote: String {
        guard checkInCount > 0 else {
            return "No check-ins this week yet — and that is okay. Come back to yourself whenever you have a minute."
        }
        var pieces: [String] = []
        pieces.append(checkInCount == 1
            ? "This week you checked in once."
            : "This week you checked in \(checkInCount) times.")
        if let petal = mostFrequentPetal {
            pieces.append("\"\(petal.displayName)\" showed up most often — just a notice, not a judgment.")
        }
        if let practice = mostUsedPractice {
            pieces.append("\"\(practice.name)\" resonated with you more than the others.")
        }
        return pieces.joined(separator: " ")
    }
}
