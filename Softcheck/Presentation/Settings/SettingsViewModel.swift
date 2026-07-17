import Foundation

@Observable
@MainActor
final class SettingsViewModel {
    static let appearanceStorageKey = "appearanceMode"
    static let reminderEnabledStorageKey = "gentleReminderEnabled"
    static let reminderHourStorageKey = "gentleReminderHour"
    static let reminderMinuteStorageKey = "gentleReminderMinute"

    var appearance: AppearanceMode {
        didSet { UserDefaults.standard.set(appearance.rawValue, forKey: Self.appearanceStorageKey) }
    }

    var reminderEnabled: Bool {
        didSet {
            UserDefaults.standard.set(reminderEnabled, forKey: Self.reminderEnabledStorageKey)
            handleReminderToggle()
        }
    }

    var reminderTime: Date {
        didSet { persistReminderTime() }
    }

    var showResetConfirmation = false
    private(set) var didResetData = false

    private let notificationService: NotificationService
    private let resetCheckInDataUseCase: ResetCheckInDataUseCase

    init(notificationService: NotificationService, resetCheckInDataUseCase: ResetCheckInDataUseCase) {
        self.notificationService = notificationService
        self.resetCheckInDataUseCase = resetCheckInDataUseCase

        let defaults = UserDefaults.standard
        let storedAppearance = defaults.string(forKey: Self.appearanceStorageKey)
        self.appearance = storedAppearance.flatMap(AppearanceMode.init(rawValue:)) ?? .system
        self.reminderEnabled = defaults.bool(forKey: Self.reminderEnabledStorageKey)

        let hour = defaults.object(forKey: Self.reminderHourStorageKey) as? Int ?? 20
        let minute = defaults.object(forKey: Self.reminderMinuteStorageKey) as? Int ?? 0
        var components = DateComponents()
        components.hour = hour
        components.minute = minute
        self.reminderTime = Calendar.current.date(from: components) ?? .now
    }

    private func handleReminderToggle() {
        if reminderEnabled {
            Task {
                let granted = await notificationService.requestAuthorization()
                if granted {
                    await scheduleReminder()
                } else {
                    reminderEnabled = false
                }
            }
        } else {
            notificationService.cancelGentleReminder()
        }
    }

    private func persistReminderTime() {
        let components = Calendar.current.dateComponents([.hour, .minute], from: reminderTime)
        UserDefaults.standard.set(components.hour, forKey: Self.reminderHourStorageKey)
        UserDefaults.standard.set(components.minute, forKey: Self.reminderMinuteStorageKey)
        if reminderEnabled {
            Task { await scheduleReminder() }
        }
    }

    private func scheduleReminder() async {
        let components = Calendar.current.dateComponents([.hour, .minute], from: reminderTime)
        await notificationService.scheduleGentleReminder(hour: components.hour ?? 20, minute: components.minute ?? 0)
    }

    func resetAllData() {
        Task {
            try? await resetCheckInDataUseCase.execute()
            didResetData = true
            HapticsService.warning()
        }
    }
}
