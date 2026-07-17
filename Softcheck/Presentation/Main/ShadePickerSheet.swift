import SwiftUI

/// Appears after a petal is tapped — asks "what do I need right now?",
/// never "what's wrong?". Picking a shade is the only action here.
struct ShadePickerSheet: View {
    let petal: EmotionPetal
    let isSaving: Bool
    let onChooseShade: (String) -> Void
    let onCancel: () -> Void

    var body: some View {
        VStack(spacing: 28) {
            Capsule()
                .fill(AppColor.secondary.opacity(0.4))
                .frame(width: 36, height: 5)
                .padding(.top, 10)

            VStack(spacing: 8) {
                Image(systemName: petal.symbolName)
                    .font(.title)
                    .foregroundStyle(petal.tint)
                Text(petal.displayName)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(AppColor.text)
                Text("Which shade is closest to what you would call this?")
                    .font(.subheadline)
                    .foregroundStyle(AppColor.text.opacity(0.65))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 24)

            VStack(spacing: 12) {
                ForEach(petal.shades) { shade in
                    Button {
                        onChooseShade(shade.id)
                    } label: {
                        HStack(alignment: .center, spacing: 12) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(shade.label)
                                    .font(.body.weight(.medium))
                                    .foregroundStyle(AppColor.text)
                                Text(shade.supportiveCopy)
                                    .font(.caption)
                                    .foregroundStyle(AppColor.text.opacity(0.6))
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer(minLength: 8)
                            if isSaving {
                                ProgressView()
                            } else {
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(AppColor.text.opacity(0.4))
                            }
                        }
                        .padding(16)
                        .background(petal.tint.opacity(0.18))
                        .clipShape(RoundedRectangle(cornerRadius: 22))
                    }
                    .buttonStyle(.plain)
                    .disabled(isSaving)
                }
            }
            .padding(.horizontal, 24)

            Spacer()
        }
        .background(AppColor.background)
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.hidden)
    }
}

#Preview {
    ShadePickerSheet(petal: .anxious, isSaving: false, onChooseShade: { _ in }, onCancel: {})
}
