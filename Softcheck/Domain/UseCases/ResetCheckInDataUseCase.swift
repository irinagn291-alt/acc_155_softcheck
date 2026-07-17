import Foundation

/// Clears all locally-stored check-ins — used by the Settings reset action.
protocol ResetCheckInDataUseCase {
    func execute() async throws
}

final class DefaultResetCheckInDataUseCase: ResetCheckInDataUseCase {
    private let repository: CheckInRepository

    init(repository: CheckInRepository) {
        self.repository = repository
    }

    func execute() async throws {
        try await repository.deleteAll()
    }
}
