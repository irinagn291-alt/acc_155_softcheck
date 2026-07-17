import SwiftUI

struct GroundingShelfView: View {
    private let scripts: [(title: String, body: String, symbol: String)] = [
        (
            "Box breath",
            "Inhale 4 · hold 4 · exhale 4 · hold 4. Repeat four rounds. Keep shoulders soft.",
            "wind"
        ),
        (
            "Name the room",
            "Look around and quietly name five colors, four textures, three sounds. You are here.",
            "eye"
        ),
        (
            "Feet on floor",
            "Press both feet into the ground. Notice pressure, temperature, contact. Stay for one minute.",
            "figure.stand"
        ),
        (
            "Cold water reset",
            "Rinse hands or wrists with cool water. Feel the temperature change without judging it.",
            "drop"
        ),
        (
            "One kind sentence",
            "Say to yourself: “This is hard, and I can take the next small step.” No fixing required.",
            "heart"
        ),
    ]

    var body: some View {
        NavigationStack {
            List {
                Section {
                    CrisisResourcesView()
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                }

                Section("Grounding scripts") {
                    ForEach(Array(scripts.enumerated()), id: \.offset) { _, script in
                        VStack(alignment: .leading, spacing: 8) {
                            Label(script.title, systemImage: script.symbol)
                                .font(.headline)
                                .foregroundStyle(AppColor.text)
                            Text(script.body)
                                .font(.subheadline)
                                .foregroundStyle(AppColor.text.opacity(0.75))
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(AppColor.background.ignoresSafeArea())
            .navigationTitle("Grounding")
        }
    }
}
