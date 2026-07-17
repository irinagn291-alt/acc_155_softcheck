import SwiftData
import SwiftUI

/// Switches between the mood-baseline onboarding and the main tab flow once
/// `AppDependencies` has been built from the live `ModelContext`.
struct RootView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @Environment(\.modelContext) private var modelContext
    @State private var dependencies: AppDependencies?

    var body: some View {
        Group {
            if let dependencies {
                if hasCompletedOnboarding {
                    MainTabView(dependencies: dependencies)
                } else {
                    OnboardingContainerView(
                        viewModel: dependencies.makeOnboardingViewModel(),
                        onFinish: { hasCompletedOnboarding = true }
                    )
                }
            } else {
                AppColor.background.ignoresSafeArea()
            }
        }
        .tint(AppColor.accent)
        .preferredColorScheme(.light)
        .task {
            if dependencies == nil {
                dependencies = AppDependencies(modelContext: modelContext)
            }
        }
    }
}
