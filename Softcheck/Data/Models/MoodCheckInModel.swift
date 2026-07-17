import Foundation
import SwiftData

/// SwiftData persistence model mirroring the `MoodCheckIn` domain entity.
@Model
final class MoodCheckInModel {
    @Attribute(.unique) var id: UUID
    var petalRawValue: String
    var shadeID: String
    var timestamp: Date
    var matchedPracticeID: String?
    var note: String?

    init(
        id: UUID,
        petalRawValue: String,
        shadeID: String,
        timestamp: Date,
        matchedPracticeID: String?,
        note: String?
    ) {
        self.id = id
        self.petalRawValue = petalRawValue
        self.shadeID = shadeID
        self.timestamp = timestamp
        self.matchedPracticeID = matchedPracticeID
        self.note = note
    }
}

extension MoodCheckInModel {
    convenience init(checkIn: MoodCheckIn) {
        self.init(
            id: checkIn.id,
            petalRawValue: checkIn.petal.rawValue,
            shadeID: checkIn.shadeID,
            timestamp: checkIn.timestamp,
            matchedPracticeID: checkIn.matchedPracticeID,
            note: checkIn.note
        )
    }

    func toDomain() -> MoodCheckIn? {
        guard let petal = EmotionPetal(rawValue: petalRawValue) else { return nil }
        return MoodCheckIn(
            id: id,
            petal: petal,
            shadeID: shadeID,
            timestamp: timestamp,
            matchedPracticeID: matchedPracticeID,
            note: note
        )
    }
}
