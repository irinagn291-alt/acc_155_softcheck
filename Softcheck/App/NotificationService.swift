import Foundation
import UserNotifications

/// Schedules the single, optional gentle check-in reminder.
/// Uses only `UNUserNotificationCenter` — no push, no remote services.
protocol NotificationService {
    func requestAuthorization() async -> Bool
    func scheduleGentleReminder(hour: Int, minute: Int) async
    func cancelGentleReminder()
    func isAuthorized() async -> Bool
}

final class LocalNotificationService: NotificationService {
    private static let reminderIdentifier = "softcheck.gentle-reminder"

    func requestAuthorization() async -> Bool {
        let center = UNUserNotificationCenter.current()
        do {
            return try await center.requestAuthorization(options: [.alert, .sound])
        } catch {
            return false
        }
    }

    func isAuthorized() async -> Bool {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        return settings.authorizationStatus == .authorized
    }

    func scheduleGentleReminder(hour: Int, minute: Int) async {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [Self.reminderIdentifier])

        let content = UNMutableNotificationContent()
        content.title = "Softcheck"
        content.body = "A minute to pause. How are you, really, right now?"
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: Self.reminderIdentifier, content: content, trigger: trigger)
        try? await center.add(request)
    }

    func cancelGentleReminder() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [Self.reminderIdentifier])
    }
}
