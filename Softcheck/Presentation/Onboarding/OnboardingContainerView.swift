import SwiftUI

struct OnboardingContainerView: View {
    @Bindable var viewModel: OnboardingViewModel
    let onFinish: () -> Void

    var body: some View {
        ZStack {
            AppColor.background.ignoresSafeArea()

            Group {
                switch viewModel.pageIndex {
                case 0:
                    firstCheckInPage
                case 1:
                    helpCategoriesPage
                case 2:
                    promisePage
                case 3:
                    reminderPage
                default:
                    revealPage
                }
            }
            .animation(.easeInOut, value: viewModel.pageIndex)
        }
        .tint(AppColor.accent)
    }

    private var firstCheckInPage: some View {
        VStack(spacing: 24) {
            Spacer()
            Text("Softcheck")
                .font(.system(.largeTitle, design: .serif).weight(.semibold))
                .foregroundStyle(AppColor.text)
            Text("Where shall we begin — which petal feels true right now?")
                .font(.subheadline)
                .foregroundStyle(AppColor.text.opacity(0.65))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 28)

            MoodPetalsWheelView(
                selectedPetal: viewModel.selectedPetal,
                onSelectPetal: { viewModel.selectPetal($0) }
            )

            if let petal = viewModel.selectedPetal {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(petal.shades) { shade in
                            Button {
                                viewModel.selectShade(shade.id)
                            } label: {
                                Text(shade.label)
                                    .font(.subheadline.weight(.medium))
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 18)
                                            .fill(viewModel.selectedShadeID == shade.id
                                                  ? petal.tint.opacity(0.45)
                                                  : AppColor.surface)
                                    )
                                    .foregroundStyle(AppColor.text)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }

            Button {
                Task { await viewModel.submitFirstCheckIn() }
            } label: {
                Text(viewModel.isSubmittingFirstCheckIn ? "Saving…" : "Continue")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
            }
            .buttonStyle(.borderedProminent)
            .tint(AppColor.primary)
            .disabled(!viewModel.canSubmitFirstCheckIn || viewModel.isSubmittingFirstCheckIn)
            .padding(.horizontal, 28)
            .padding(.bottom, 28)
        }
    }

    private var helpCategoriesPage: some View {
        VStack(spacing: 24) {
            Spacer()
            Text("What usually helps?")
                .font(.system(.title, design: .serif).weight(.semibold))
                .foregroundStyle(AppColor.text)
            Text("You can pick several — just so Softcheck can suggest practices that fit you better.")
                .font(.subheadline)
                .foregroundStyle(AppColor.text.opacity(0.65))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 28)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 12)], spacing: 12) {
                ForEach(PracticeCategory.allCases, id: \.self) { category in
                    Button {
                        viewModel.toggleHelpCategory(category)
                    } label: {
                        HStack {
                            Image(systemName: category.symbolName)
                            Text(category.displayTitle)
                                .font(.subheadline.weight(.medium))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .fill(viewModel.selectedHelpCategories.contains(category)
                                      ? AppColor.primary.opacity(0.25)
                                      : AppColor.surface)
                        )
                        .foregroundStyle(AppColor.text)
                    }
                }
            }
            .padding(.horizontal, 24)

            Spacer()

            Button("Continue") { viewModel.advance() }
                .buttonStyle(.borderedProminent)
                .tint(AppColor.primary)
                .padding(.horizontal, 28)
                .padding(.bottom, 28)
        }
    }

    private var promisePage: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: "heart")
                .font(.system(size: 44))
                .foregroundStyle(AppColor.primary)
            Text("No judgments")
                .font(.system(.title, design: .serif).weight(.semibold))
                .foregroundStyle(AppColor.text)
            Text("There is no \"good\" or \"bad\" here. Only what you feel — and a gentle practice, if it resonates.")
                .font(.body)
                .foregroundStyle(AppColor.text.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Spacer()
            Button("Got it") { viewModel.advance() }
                .buttonStyle(.borderedProminent)
                .tint(AppColor.primary)
                .padding(.horizontal, 28)
                .padding(.bottom, 28)
        }
    }

    private var reminderPage: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: "bell")
                .font(.system(size: 40))
                .foregroundStyle(AppColor.primary)
            Text("A gentle reminder")
                .font(.system(.title, design: .serif).weight(.semibold))
                .foregroundStyle(AppColor.text)
            Text("We can quietly nudge you in the evening: \"A minute to pause. How are you, really, right now?\"")
                .font(.body)
                .foregroundStyle(AppColor.text.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Spacer()
            VStack(spacing: 12) {
                Button {
                    Task { await viewModel.requestReminderPermission() }
                } label: {
                    Text(viewModel.isRequestingReminder ? "Asking…" : "Allow")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                }
                .buttonStyle(.borderedProminent)
                .tint(AppColor.primary)
                .disabled(viewModel.isRequestingReminder)

                Button("Not now") { viewModel.skipReminder() }
                    .foregroundStyle(AppColor.text.opacity(0.7))
            }
            .padding(.horizontal, 28)
            .padding(.bottom, 28)
        }
    }

    private var revealPage: some View {
        VStack(spacing: 24) {
            Spacer()
            MoodPetalsWheelView(selectedPetal: nil, onSelectPetal: { _ in })
                .scaleEffect(0.9)
            Text("Your wheel is ready")
                .font(.system(.title, design: .serif).weight(.semibold))
                .foregroundStyle(AppColor.text)
            Text("Come by when you need a pause — no judgments, no pressure.")
                .font(.subheadline)
                .foregroundStyle(AppColor.text.opacity(0.65))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Spacer()
            Button("Begin") { onFinish() }
                .buttonStyle(.borderedProminent)
                .tint(AppColor.primary)
                .padding(.horizontal, 28)
                .padding(.bottom, 28)
        }
    }
}

private extension PracticeCategory {
    var displayTitle: String {
        switch self {
        case .breathing: return "Breathing"
        case .grounding: return "Grounding"
        case .journaling: return "Journaling"
        case .movement: return "Movement"
        case .connection: return "Connection"
        case .rest: return "Rest"
        case .senses: return "Senses"
        }
    }
}

#Preview {
    OnboardingContainerView(
        viewModel: PreviewContainer.shared.dependencies.makeOnboardingViewModel(),
        onFinish: {}
    )
}
