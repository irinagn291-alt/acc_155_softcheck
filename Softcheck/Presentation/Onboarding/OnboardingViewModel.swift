import Foundation

/// Drives the 5-screen "mood-baseline" onboarding: first check-in, what
/// usually helps, the no-judgment promise, a gentle reminder opt-in, and the
/// wheel reveal.
@Observable
@MainActor
final class OnboardingViewModel {
    var pageIndex: Int = 0

    var selectedPetal: EmotionPetal?
    var selectedShadeID: String?
    private(set) var matchedPractice: Practice?
    private(set) var isSubmittingFirstCheckIn = false

    private(set) var selectedHelpCategories: Set<PracticeCategory> = []

    private(set) var reminderAuthorized = false
    private(set) var isRequestingReminder = false

    private let checkInUseCase: CheckInUseCase
    private let notificationService: NotificationService

    init(checkInUseCase: CheckInUseCase, notificationService: NotificationService) {
        self.checkInUseCase = checkInUseCase
        self.notificationService = notificationService
    }

    var canSubmitFirstCheckIn: Bool { selectedPetal != nil && selectedShadeID != nil }

    func selectPetal(_ petal: EmotionPetal) {
        selectedPetal = petal
        selectedShadeID = nil
    }

    func selectShade(_ shadeID: String) {
        selectedShadeID = shadeID
    }

    func submitFirstCheckIn() async {
        guard let petal = selectedPetal, let shadeID = selectedShadeID else { return }
        isSubmittingFirstCheckIn = true
        defer { isSubmittingFirstCheckIn = false }

        do {
            let result = try await checkInUseCase.execute(petal: petal, shadeID: shadeID, note: nil, at: .now)
            matchedPractice = result.practice
            HapticsService.practiceRevealed()
            pageIndex = 1
        } catch {
            pageIndex = 1
        }
    }

    func toggleHelpCategory(_ category: PracticeCategory) {
        if selectedHelpCategories.contains(category) {
            selectedHelpCategories.remove(category)
        } else {
            selectedHelpCategories.insert(category)
        }
    }

    func advance() {
        pageIndex = min(pageIndex + 1, 4)
    }

    func requestReminderPermission() async {
        isRequestingReminder = true
        defer { isRequestingReminder = false }

        let granted = await notificationService.requestAuthorization()
        reminderAuthorized = granted
        if granted {
            await notificationService.scheduleGentleReminder(hour: 20, minute: 0)
        }
        advance()
    }

    func skipReminder() {
        advance()
    }
}
