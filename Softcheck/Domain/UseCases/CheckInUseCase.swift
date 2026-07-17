import Foundation

/// Records a check-in (petal + shade) and matches it to a recommended
/// `Practice`, never a score — the app's quiet moment of outcome.
protocol CheckInUseCase {
    @discardableResult
    func execute(petal: EmotionPetal, shadeID: String, note: String?, at date: Date) async throws -> (checkIn: MoodCheckIn, practice: Practice)
}

final class DefaultCheckInUseCase: CheckInUseCase {
    private let repository: CheckInRepository

    init(repository: CheckInRepository) {
        self.repository = repository
    }

    @discardableResult
    func execute(
        petal: EmotionPetal,
        shadeID: String,
        note: String? = nil,
        at date: Date = .now
    ) async throws -> (checkIn: MoodCheckIn, practice: Practice) {
        let practice = PracticeCatalog.match(shadeID: shadeID)
        let checkIn = MoodCheckIn(
            petal: petal,
            shadeID: shadeID,
            timestamp: date,
            matchedPracticeID: practice.id,
            note: note
        )
        try await repository.insert(checkIn)
        return (checkIn, practice)
    }
}
