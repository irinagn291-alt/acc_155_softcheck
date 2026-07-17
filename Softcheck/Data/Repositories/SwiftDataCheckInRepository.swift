import Foundation
import SwiftData

/// Concrete `CheckInRepository` backed by a SwiftData `ModelContext`.
/// Pinned to the main actor because `ModelContext` is not safe to share across threads.
@MainActor
final class SwiftDataCheckInRepository: CheckInRepository {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func fetchAll() async throws -> [MoodCheckIn] {
        let descriptor = FetchDescriptor<MoodCheckInModel>(sortBy: [SortDescriptor(\.timestamp)])
        return try modelContext.fetch(descriptor).compactMap { $0.toDomain() }
    }

    func fetchSince(_ date: Date) async throws -> [MoodCheckIn] {
        let descriptor = FetchDescriptor<MoodCheckInModel>(
            predicate: #Predicate { $0.timestamp >= date },
            sortBy: [SortDescriptor(\.timestamp)]
        )
        return try modelContext.fetch(descriptor).compactMap { $0.toDomain() }
    }

    func insert(_ checkIn: MoodCheckIn) async throws {
        modelContext.insert(MoodCheckInModel(checkIn: checkIn))
        try modelContext.save()
    }

    func deleteAll() async throws {
        try modelContext.delete(model: MoodCheckInModel.self)
        try modelContext.save()
    }
}
