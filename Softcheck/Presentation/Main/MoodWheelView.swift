import SwiftUI

/// Main screen — the radial mood-petals wheel. Tapping a petal opens a
/// shade picker, then reveals a matched practice with a gentle haptic.
struct MoodWheelView: View {
    @State private var viewModel: CheckInViewModel
    @State private var showPetalHarmony = false

    init(dependencies: AppDependencies) {
        _viewModel = State(wrappedValue: dependencies.makeCheckInViewModel())
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Spacer()

                VStack(spacing: 10) {
                    Text("Softcheck")
                        .font(.system(.largeTitle, design: .serif).weight(.semibold))
                        .foregroundStyle(AppColor.text)
                    Text("Tap the petal that feels true right now.")
                        .font(.subheadline)
                        .foregroundStyle(AppColor.text.opacity(0.6))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }

                MoodPetalsWheelView(
                    selectedPetal: viewModel.petalForShadePicker,
                    onSelectPetal: { viewModel.selectPetal($0) }
                )

                Spacer()

                Button {
                    showPetalHarmony = true
                } label: {
                    Label("Petal harmony", systemImage: "leaf.circle")
                        .font(.subheadline.weight(.medium))
                }
                .buttonStyle(.bordered)
                .tint(AppColor.primary)
                .accessibilityLabel("Petal harmony")
                .accessibilityHint("Opens a grounding petal alignment game")

                Text("No \"good\" or \"bad\" labels — just what is here.")
                    .font(.caption)
                    .foregroundStyle(AppColor.text.opacity(0.45))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 12)
            }
            .background(AppColor.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .navigationBar)
        }
        .sheet(isPresented: $showPetalHarmony) {
            PetalHarmonyView { showPetalHarmony = false }
        }
        .sheet(item: $viewModel.petalForShadePicker) { petal in
            ShadePickerSheet(
                petal: petal,
                isSaving: viewModel.isSaving,
                onChooseShade: { shadeID in
                    Task { await viewModel.chooseShade(shadeID) }
                },
                onCancel: { viewModel.dismissShadePicker() }
            )
        }
        .sheet(
            isPresented: Binding(
                get: { viewModel.revealedPractice != nil },
                set: { isPresented in if !isPresented { viewModel.dismissReveal() } }
            )
        ) {
            if let practice = viewModel.revealedPractice {
                PracticeRevealSheet(practice: practice, onDone: { viewModel.dismissReveal() })
            }
        }
        .tint(AppColor.accent)
    }
}

#Preview {
    MoodWheelView(dependencies: PreviewContainer.shared.dependencies)
}
