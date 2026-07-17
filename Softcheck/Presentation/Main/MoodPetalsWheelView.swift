import SwiftUI

/// The radial mood-petals wheel — the app's main navigation metaphor.
/// Eight soft petals arranged around a calm center; tapping one is the
/// entry point into "what do I need right now?", not "what's wrong?".
struct MoodPetalsWheelView: View {
    let selectedPetal: EmotionPetal?
    let onSelectPetal: (EmotionPetal) -> Void

    private let petals = EmotionPetal.allCases
    private let wheelDiameter: CGFloat = 300

    private var petalSize: CGSize {
        CGSize(width: wheelDiameter * 0.30, height: wheelDiameter * 0.46)
    }

    private var radius: CGFloat { wheelDiameter * 0.27 }

    var body: some View {
        ZStack {
            ForEach(Array(petals.enumerated()), id: \.element) { index, petal in
                petalButton(for: petal, index: index)
            }
            centerCore
        }
        .frame(width: wheelDiameter, height: wheelDiameter)
    }

    private func angle(for index: Int) -> Angle {
        .degrees(Double(index) / Double(petals.count) * 360)
    }

    private func petalButton(for petal: EmotionPetal, index: Int) -> some View {
        let theta = angle(for: index)
        let isSelected = selectedPetal == petal

        return Button {
            onSelectPetal(petal)
        } label: {
            ZStack {
                PetalShape()
                    .fill(petal.tint.opacity(isSelected ? 1 : 0.82))
                    .overlay(
                        PetalShape()
                            .stroke(AppColor.surface.opacity(isSelected ? 0.9 : 0), lineWidth: 2)
                    )
                    .frame(width: petalSize.width, height: petalSize.height)
                    .shadow(color: AppColor.text.opacity(0.06), radius: isSelected ? 6 : 2, y: 2)

                Image(systemName: petal.symbolName)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(AppColor.text.opacity(0.7))
                    .rotationEffect(-theta)
                    .offset(y: -petalSize.height * 0.26)
            }
        }
        .buttonStyle(.plain)
        .offset(y: -radius)
        .rotationEffect(theta)
        .scaleEffect(isSelected ? 1.07 : 1.0)
        .animation(.spring(response: 0.35, dampingFraction: 0.75), value: isSelected)
        .accessibilityLabel(petal.displayName)
    }

    private var centerCore: some View {
        Circle()
            .fill(AppColor.surface)
            .frame(width: wheelDiameter * 0.32, height: wheelDiameter * 0.32)
            .shadow(color: AppColor.text.opacity(0.08), radius: 12, y: 4)
            .overlay {
                VStack(spacing: 4) {
                    Image(systemName: "heart")
                        .font(.title3)
                        .foregroundStyle(AppColor.primary)
                    Text("How are\nyou now?")
                        .font(.caption.weight(.medium))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(AppColor.text)
                }
            }
    }
}

#Preview {
    MoodPetalsWheelView(selectedPetal: .calm, onSelectPetal: { _ in })
        .padding(40)
        .background(AppColor.background)
}
