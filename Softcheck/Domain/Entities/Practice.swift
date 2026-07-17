import Foundation

/// A gentle micro-practice (breathing, grounding, journaling prompt, stretch...)
/// that can be matched to one or more `EmotionShade`s.
struct Practice: Identifiable, Hashable, Sendable {
    let id: String
    let category: PracticeCategory
    let name: String
    let description: String
    let matchedShadeIDs: [String]
    let duration: TimeInterval
}

extension Practice {
    var durationLabel: String {
        let minutes = max(1, Int(duration / 60))
        return "\(minutes) min"
    }
}
