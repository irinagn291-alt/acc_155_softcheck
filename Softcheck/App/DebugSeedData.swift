import Foundation

#if DEBUG
/// Demo check-ins for DEBUG simulator builds only. Never ships in Release.
enum DebugSeedData {
    static var isAvailable: Bool {
        #if targetEnvironment(simulator)
        true
        #else
        false
        #endif
    }

    /// 21 days of soft check-ins with varied petals/shades/practices.
    static func checkIns(referenceDate: Date = .now, calendar: Calendar = .current) -> [MoodCheckIn] {
        let shades = EmotionShade.all
        let practices = PracticeCatalog.all
        var items: [MoodCheckIn] = []
        for dayOffset in (0..<21).reversed() {
            guard let day = calendar.date(byAdding: .day, value: -dayOffset, to: referenceDate) else { continue }
            let shade = shades[dayOffset % shades.count]
            let practice = practices[dayOffset % practices.count]
            let hour = 8 + (dayOffset % 12)
            var components = calendar.dateComponents([.year, .month, .day], from: day)
            components.hour = hour
            components.minute = (dayOffset * 7) % 60
            let timestamp = calendar.date(from: components) ?? day
            items.append(
                MoodCheckIn(
                    petal: shade.petal,
                    shadeID: shade.id,
                    timestamp: timestamp,
                    matchedPracticeID: practice.id,
                    note: dayOffset % 5 == 0 ? "Demo note — a quiet pause." : nil
                )
            )
        }
        return items
    }

    @MainActor
    static func load(into repository: CheckInRepository) async throws {
        guard isAvailable else { return }
        try await repository.deleteAll()
        for checkIn in checkIns() {
            try await repository.insert(checkIn)
        }
    }

    @MainActor
    static func reset(into repository: CheckInRepository) async throws {
        guard isAvailable else { return }
        try await repository.deleteAll()
    }
}
#endif
