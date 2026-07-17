import SwiftUI

/// Optional simple countdown while holding a revealed practice.
/// Skip and stop are always available — never guilt-framed.
struct TimedPracticeHoldSheet: View {
    let practice: Practice
    let onFinished: () -> Void

    @Environment(\.dismiss) private var dismiss
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var remaining: Int = 0
    @State private var isRunning = false
    @State private var timerTask: Task<Void, Never>?

    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                Text(practice.name)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(AppColor.text)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Text(isRunning ? "Holding gently…" : "Optional timed hold")
                    .font(.subheadline)
                    .foregroundStyle(AppColor.text.opacity(0.6))

                ZStack {
                    Circle()
                        .stroke(AppColor.secondary.opacity(0.25), lineWidth: 10)
                        .frame(width: 160, height: 160)
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(AppColor.primary, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .frame(width: 160, height: 160)
                        .rotationEffect(.degrees(-90))
                        .animation(reduceMotion ? nil : .linear(duration: 0.2), value: remaining)
                    Text(timeLabel)
                        .font(.system(.largeTitle, design: .rounded).weight(.medium))
                        .foregroundStyle(AppColor.text)
                        .monospacedDigit()
                }

                HStack(spacing: 16) {
                    if isRunning {
                        Button("Stop") { stop(finish: false) }
                            .buttonStyle(.bordered)
                        Button("Skip") { stop(finish: true) }
                            .buttonStyle(.borderedProminent)
                            .tint(AppColor.primary)
                    } else {
                        Button("Start \(Int(practice.duration))s") { start() }
                            .buttonStyle(.borderedProminent)
                            .tint(AppColor.primary)
                        Button("Skip") { stop(finish: true) }
                            .buttonStyle(.bordered)
                    }
                }
                Spacer(minLength: 0)
            }
            .padding(24)
            .background(AppColor.background)
            .navigationTitle("Timed hold")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { stop(finish: false) }
                }
            }
            .onDisappear { timerTask?.cancel() }
        }
    }

    private var total: Int { max(1, Int(practice.duration)) }

    private var progress: CGFloat {
        guard total > 0 else { return 0 }
        return CGFloat(total - remaining) / CGFloat(total)
    }

    private var timeLabel: String {
        let value = isRunning ? remaining : total
        let minutes = value / 60
        let seconds = value % 60
        return String(format: "%d:%02d", minutes, seconds)
    }

    private func start() {
        remaining = total
        isRunning = true
        timerTask?.cancel()
        timerTask = Task { @MainActor in
            while remaining > 0, !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                if Task.isCancelled { return }
                remaining -= 1
            }
            if remaining == 0, isRunning {
                HapticsService.practiceRevealed()
                stop(finish: true)
            }
        }
    }

    private func stop(finish: Bool) {
        timerTask?.cancel()
        timerTask = nil
        isRunning = false
        if finish {
            onFinished()
        }
        dismiss()
    }
}

#Preview {
    TimedPracticeHoldSheet(practice: PracticeCatalog.all[0], onFinished: {})
}
