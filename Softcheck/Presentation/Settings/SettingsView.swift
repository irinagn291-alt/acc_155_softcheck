import SwiftUI

/// Appearance, gentle-reminder toggle, about/reset, and a prominent
/// crisis-resources + "not a substitute for therapy" disclaimer.
struct SettingsView: View {
    private let dependencies: AppDependencies
    @State private var viewModel: SettingsViewModel
    #if DEBUG
    @State private var seedMessage: String?
    #endif

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
        _viewModel = State(wrappedValue: dependencies.makeSettingsViewModel())
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Gentle reminder") {
                    Toggle("Remind me to check in", isOn: $viewModel.reminderEnabled)
                    if viewModel.reminderEnabled {
                        DatePicker("Time", selection: $viewModel.reminderTime, displayedComponents: .hourAndMinute)
                    }
                    Text("\"A minute to pause. How are you, really, right now?\"")
                        .font(.footnote)
                        .foregroundStyle(AppColor.text.opacity(0.55))
                }

                Section("About") {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Softcheck")
                            .font(.headline)
                        Text("Be kind to yourself — start with \"how are you?\".")
                            .font(.subheadline)
                            .foregroundStyle(AppColor.text.opacity(0.65))
                    }
                    .padding(.vertical, 4)
                }

                Section {
                    CrisisResourcesView()
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                }

                #if DEBUG
                if DebugSeedData.isAvailable {
                    Section("Debug demo") {
                        Button("Load demo check-ins") {
                            Task { await loadDemoSeed() }
                        }
                        Button("Reset demo data", role: .destructive) {
                            Task { await resetDemoSeed() }
                        }
                        Text("Simulator-only seed: 21 days of check-ins.")
                            .font(.footnote)
                            .foregroundStyle(AppColor.text.opacity(0.55))
                    }
                }
                #endif

                Section {
                    Button(role: .destructive) {
                        viewModel.showResetConfirmation = true
                    } label: {
                        Text("Reset check-in data")
                    }
                }
            }
            .navigationTitle("Settings")
            .scrollContentBackground(.hidden)
            .frame(maxWidth: 700)
            .frame(maxWidth: .infinity)
            .background(AppColor.background)
            .alert("Reset all check-ins?", isPresented: $viewModel.showResetConfirmation) {
                Button("Cancel", role: .cancel) {}
                Button("Reset", role: .destructive) {
                    viewModel.resetAllData()
                }
            } message: {
                Text("This cannot be undone. Your practices library will stay in place.")
            }
            #if DEBUG
            .alert("Demo data", isPresented: Binding(
                get: { seedMessage != nil },
                set: { if !$0 { seedMessage = nil } }
            )) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(seedMessage ?? "")
            }
            #endif
        }
    }

    #if DEBUG
    private func loadDemoSeed() async {
        do {
            try await DebugSeedData.load(into: dependencies.checkInRepository)
            seedMessage = "Loaded 21 demo check-ins."
        } catch {
            seedMessage = "Couldn't load demo check-ins."
        }
    }

    private func resetDemoSeed() async {
        do {
            try await DebugSeedData.reset(into: dependencies.checkInRepository)
            seedMessage = "Demo check-ins cleared."
        } catch {
            seedMessage = "Couldn't reset demo data."
        }
    }
    #endif
}

#Preview {
    SettingsView(dependencies: PreviewContainer.shared.dependencies)
}
