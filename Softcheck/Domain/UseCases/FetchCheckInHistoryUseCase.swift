import Foundation

/// Reads back the full (or recent) check-in history for the Patterns dashboard.
protocol FetchCheckInHistoryUseCase {
    func execute() async throws -> [MoodCheckIn]
    func execute(since date: Date) async throws -> [MoodCheckIn]
}

final class DefaultFetchCheckInHistoryUseCase: FetchCheckInHistoryUseCase {
    private let repository: CheckInRepository

    init(repository: CheckInRepository) {
        self.repository = repository
    }

    func execute() async throws -> [MoodCheckIn] {
        try await repository.fetchAll()
    }

    func execute(since date: Date) async throws -> [MoodCheckIn] {
        try await repository.fetchSince(date)
    }
}
