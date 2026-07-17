import Foundation

/// A single day's check-in count, for the frequency chart.
struct DailyFrequencyPoint: Identifiable {
    let date: Date
    let count: Int
    var id: Date { date }
}

/// How many check-ins landed in each petal, for the shade-distribution chart.
struct PetalDistributionPoint: Identifiable {
    let petal: EmotionPetal
    let count: Int
    var id: String { petal.id }
}

/// Loads check-in history for the Patterns dashboard and derives chart data
/// and the quiet weekly caring review — never a good/bad score.
@Observable
@MainActor
final class PatternsViewModel {
    private(set) var checkIns: [MoodCheckIn] = []
    private(set) var weeklyReview: WeeklyCaringReview?
    private(set) var isLoading = false

    private let fetchCheckInHistoryUseCase: FetchCheckInHistoryUseCase
    private let computeWeeklyCaringReviewUseCase: ComputeWeeklyCaringReviewUseCase
    private let historyWindowInDays = 14

    init(
        fetchCheckInHistoryUseCase: FetchCheckInHistoryUseCase,
        computeWeeklyCaringReviewUseCase: ComputeWeeklyCaringReviewUseCase
    ) {
        self.fetchCheckInHistoryUseCase = fetchCheckInHistoryUseCase
        self.computeWeeklyCaringReviewUseCase = computeWeeklyCaringReviewUseCase
    }

    var hasData: Bool { !checkIns.isEmpty }

    var dailyFrequency: [DailyFrequencyPoint] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        let counts = Dictionary(grouping: checkIns) { calendar.startOfDay(for: $0.timestamp) }
            .mapValues(\.count)

        return (0..<historyWindowInDays).reversed().compactMap { offset in
            guard let day = calendar.date(byAdding: .day, value: -offset, to: today) else { return nil }
            return DailyFrequencyPoint(date: day, count: counts[day] ?? 0)
        }
    }

    var petalDistribution: [PetalDistributionPoint] {
        let counts = Dictionary(grouping: checkIns, by: \.petal).mapValues(\.count)
        return EmotionPetal.allCases
            .map { PetalDistributionPoint(petal: $0, count: counts[$0] ?? 0) }
            .filter { $0.count > 0 }
    }

    func load() async {
        isLoading = true
        defer { isLoading = false }
        checkIns = (try? await fetchCheckInHistoryUseCase.execute()) ?? []
        weeklyReview = computeWeeklyCaringReviewUseCase.execute(checkIns: checkIns, referenceDate: .now)
    }
}
