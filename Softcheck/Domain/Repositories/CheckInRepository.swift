import Foundation

/// Abstracts persistence for mood check-ins away from any storage technology.
protocol CheckInRepository {
    func fetchAll() async throws -> [MoodCheckIn]
    func fetchSince(_ date: Date) async throws -> [MoodCheckIn]
    func insert(_ checkIn: MoodCheckIn) async throws
    func deleteAll() async throws
}
