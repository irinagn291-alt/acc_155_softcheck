import SwiftUI

/// Grounding minigame: rotate petals until they rest at aligned angles.
/// Not a mood judgment — just a soft, tactile pause.
struct PetalHarmonyView: View {
    let onDismiss: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var rotations: [Double]
    @State private var dragOrigins: [Double?]
    @State private var isComplete = false

    private let petalCount = 5
    private let snapStep: Double = 15
    private let target: Double = 0
    private let tolerance: Double = 8

    init(onDismiss: @escaping () -> Void) {
        self.onDismiss = onDismiss
        var starting: [Double] = []
        for index in 0..<5 {
            let offset = Double(((index + 1) * 37) % 150) - 75
            starting.append(offset == 0 ? 30 : offset)
        }
        _rotations = State(initialValue: starting)
        _dragOrigins = State(initialValue: Array(repeating: nil, count: 5))
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Petal harmony")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(AppColor.text)
                Text("Rotate each petal until they rest upright. A grounding pause — not a score.")
                    .font(.subheadline)
                    .foregroundStyle(AppColor.text.opacity(0.65))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 28)

                ZStack {
                    Circle()
                        .fill(AppColor.surface)
                        .frame(width: 260, height: 260)
                        .shadow(color: AppColor.text.opacity(0.06), radius: 12, y: 4)

                    ForEach(0..<petalCount, id: \.self) { index in
                        petalControl(index: index)
                    }

                    Circle()
                        .fill(AppColor.background)
                        .frame(width: 56, height: 56)
                        .overlay {
                            Image(systemName: "leaf")
                                .foregroundStyle(AppColor.primary)
                        }
                }
                .frame(height: 280)

                if isComplete {
                    Text("Aligned — stay here as long as you like.")
                        .font(.callout.weight(.medium))
                        .foregroundStyle(AppColor.primary)
                } else {
                    Text("Drag a petal, or tap to nudge by \(Int(snapStep))°.")
                        .font(.footnote)
                        .foregroundStyle(AppColor.text.opacity(0.5))
                    Button("Align petals") {
                        alignAll()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(AppColor.primary)
                }

                Spacer(minLength: 0)
            }
            .padding(24)
            .background(AppColor.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close", action: onDismiss)
                }
                if !isComplete {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Reset") { reset() }
                    }
                }
            }
        }
    }

    private func petalControl(index: Int) -> some View {
        let baseAngle = Double(index) / Double(petalCount) * 360
        let aligned = abs(normalized(rotations[index]) - target) <= tolerance

        return PetalShape()
            .fill(EmotionPetal.allCases[index % EmotionPetal.allCases.count].tint.opacity(aligned ? 1 : 0.75))
            .frame(width: 54, height: 90)
            .overlay {
                PetalShape()
                    .stroke(AppColor.surface.opacity(aligned ? 0.9 : 0.2), lineWidth: 2)
            }
            .frame(width: 72, height: 110)
            .contentShape(Rectangle())
            .offset(y: -78)
            .rotationEffect(.degrees(baseAngle + rotations[index]))
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        guard !isComplete else { return }
                        let distance = hypot(value.translation.width, value.translation.height)
                        if distance <= 8 { return }
                        if dragOrigins[index] == nil {
                            dragOrigins[index] = rotations[index]
                        }
                        let origin = dragOrigins[index] ?? rotations[index]
                        rotations[index] = snap(origin + Double(value.translation.width) * 0.45)
                        evaluate()
                    }
                    .onEnded { value in
                        defer { dragOrigins[index] = nil }
                        guard !isComplete else { return }
                        let distance = hypot(value.translation.width, value.translation.height)
                        if distance <= 8 {
                            rotations[index] = snap(rotations[index] + snapStep)
                        }
                        HapticsService.petalOpened()
                        evaluate()
                    }
            )
            .accessibilityLabel("Petal \(index + 1)")
            .accessibilityValue("\(Int(normalized(rotations[index]))) degrees")
    }

    private func snap(_ value: Double) -> Double {
        (value / snapStep).rounded() * snapStep
    }

    private func normalized(_ degrees: Double) -> Double {
        var value = degrees.truncatingRemainder(dividingBy: 360)
        if value > 180 { value -= 360 }
        if value < -180 { value += 360 }
        return value
    }

    private func evaluate() {
        let allAligned = rotations.allSatisfy { abs(normalized($0) - target) <= tolerance }
        guard allAligned, !isComplete else { return }
        isComplete = true
        HapticsService.practiceRevealed()
    }

    private func alignAll() {
        rotations = Array(repeating: target, count: petalCount)
        isComplete = true
        HapticsService.practiceRevealed()
    }

    private func reset() {
        var starting: [Double] = []
        for index in 0..<petalCount {
            let offset = Double(((index + 2) * 41) % 150) - 75
            starting.append(offset == 0 ? -45 : offset)
        }
        rotations = starting
        dragOrigins = Array(repeating: nil, count: petalCount)
        isComplete = false
    }
}

#Preview {
    PetalHarmonyView(onDismiss: {})
}
