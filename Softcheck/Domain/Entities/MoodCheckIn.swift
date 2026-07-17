import Foundation

/// A single, timestamped mood check-in: a chosen petal, a chosen shade, and
/// (once matched) the practice it led to. No score, no streak penalty.
struct MoodCheckIn: Identifiable, Equatable, Sendable {
    let id: UUID
    let petal: EmotionPetal
    let shadeID: String
    let timestamp: Date
    let matchedPracticeID: String?
    let note: String?

    init(
        id: UUID = UUID(),
        petal: EmotionPetal,
        shadeID: String,
        timestamp: Date = .now,
        matchedPracticeID: String? = nil,
        note: String? = nil
    ) {
        self.id = id
        self.petal = petal
        self.shadeID = shadeID
        self.timestamp = timestamp
        self.matchedPracticeID = matchedPracticeID
        self.note = note
    }

    var shade: EmotionShade? { EmotionShade.find(id: shadeID) }
}
