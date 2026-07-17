import Foundation
import SwiftData

/// Lightweight dependency container. Built once from the live `ModelContext`
/// and handed down through the environment, replacing any singleton lookups.
@MainActor
final class AppDependencies {
    let checkInRepository: CheckInRepository

    let checkInUseCase: CheckInUseCase
    let fetchCheckInHistoryUseCase: FetchCheckInHistoryUseCase
    let computeWeeklyCaringReviewUseCase: ComputeWeeklyCaringReviewUseCase
    let resetCheckInDataUseCase: ResetCheckInDataUseCase

    let notificationService: NotificationService

    init(modelContext: ModelContext) {
        let repository = SwiftDataCheckInRepository(modelContext: modelContext)
        self.checkInRepository = repository

        self.checkInUseCase = DefaultCheckInUseCase(repository: repository)
        self.fetchCheckInHistoryUseCase = DefaultFetchCheckInHistoryUseCase(repository: repository)
        self.computeWeeklyCaringReviewUseCase = DefaultComputeWeeklyCaringReviewUseCase()
        self.resetCheckInDataUseCase = DefaultResetCheckInDataUseCase(repository: repository)

        self.notificationService = LocalNotificationService()
    }

    func makeOnboardingViewModel() -> OnboardingViewModel {
        OnboardingViewModel(checkInUseCase: checkInUseCase, notificationService: notificationService)
    }

    func makeCheckInViewModel() -> CheckInViewModel {
        CheckInViewModel(checkInUseCase: checkInUseCase)
    }

    func makePatternsViewModel() -> PatternsViewModel {
        PatternsViewModel(
            fetchCheckInHistoryUseCase: fetchCheckInHistoryUseCase,
            computeWeeklyCaringReviewUseCase: computeWeeklyCaringReviewUseCase
        )
    }

    func makeSettingsViewModel() -> SettingsViewModel {
        SettingsViewModel(notificationService: notificationService, resetCheckInDataUseCase: resetCheckInDataUseCase)
    }
}
