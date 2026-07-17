import Foundation

/// Builds the "quiet weekly caring review" — descriptive only, with no
/// good/bad scoring, from the last 7 days of check-ins.
protocol ComputeWeeklyCaringReviewUseCase {
    func execute(checkIns: [MoodCheckIn], referenceDate: Date) -> WeeklyCaringReview
}

final class DefaultComputeWeeklyCaringReviewUseCase: ComputeWeeklyCaringReviewUseCase {
    func execute(checkIns: [MoodCheckIn], referenceDate: Date = .now) -> WeeklyCaringReview {
        let calendar = Calendar.current
        let weekStart = calendar.date(byAdding: .day, value: -7, to: referenceDate) ?? referenceDate
        let recent = checkIns.filter { $0.timestamp >= weekStart }

        let petalCounts = Dictionary(grouping: recent, by: \.petal).mapValues(\.count)
        let mostFrequentPetal = petalCounts.max { lhs, rhs in lhs.value < rhs.value }?.key

        let distinctShades = Set(recent.map(\.shadeID)).count

        let practiceCounts = Dictionary(grouping: recent.compactMap(\.matchedPracticeID), by: { $0 })
            .mapValues(\.count)
        let mostUsedPracticeID = practiceCounts.max { lhs, rhs in lhs.value < rhs.value }?.key
        let mostUsedPractice = mostUsedPracticeID.flatMap(PracticeCatalog.practice(id:))

        return WeeklyCaringReview(
            checkInCount: recent.count,
            mostFrequentPetal: mostFrequentPetal,
            distinctShadeCount: distinctShades,
            mostUsedPractice: mostUsedPractice
        )
    }
}
