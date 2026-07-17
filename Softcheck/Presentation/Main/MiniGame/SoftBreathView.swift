import SwiftUI

struct SoftBreathView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var phase: BreathPhase = .inhale
    @State private var scale: CGFloat = 0.7
    @State private var cyclesCompleted = 0
    @State private var isRunning = false

    private enum BreathPhase: String {
        case inhale = "Inhale"
        case hold = "Hold"
        case exhale = "Exhale"
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                Text(phase.rawValue)
                    .font(.system(.title2, design: .serif).weight(.semibold))
                    .foregroundStyle(AppColor.text)

                Text("Cycles \(cyclesCompleted)/4")
                    .font(.subheadline)
                    .foregroundStyle(AppColor.text.opacity(0.6))

                Circle()
                    .fill(AppColor.primary.opacity(0.35))
                    .frame(width: 180, height: 180)
                    .scaleEffect(scale)
                    .overlay {
                        Circle()
                            .stroke(AppColor.secondary.opacity(0.7), lineWidth: 3)
                            .scaleEffect(scale)
                    }

                Button(isRunning ? "Pause" : "Begin") {
                    if isRunning {
                        isRunning = false
                    } else {
                        isRunning = true
                        Task { await runCycle() }
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(AppColor.primary)

                Spacer(minLength: 0)
            }
            .padding(.top, 24)
            .background(AppColor.background.ignoresSafeArea())
            .navigationTitle("Soft Breath")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }

    private func runCycle() async {
        while isRunning && cyclesCompleted < 4 {
            await animate(.inhale, to: 1.15, duration: 3.5)
            guard isRunning else { return }
            await animate(.hold, to: 1.15, duration: 1.5)
            guard isRunning else { return }
            await animate(.exhale, to: 0.7, duration: 4)
            guard isRunning else { return }
            cyclesCompleted += 1
        }
        isRunning = false
    }

    private func animate(_ next: BreathPhase, to value: CGFloat, duration: Double) async {
        phase = next
        withAnimation(.easeInOut(duration: duration)) {
            scale = value
        }
        try? await Task.sleep(for: .seconds(duration))
    }
}

#Preview {
    SoftBreathView()
}
