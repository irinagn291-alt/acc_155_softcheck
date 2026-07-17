import SwiftUI

struct CarePlanView: View {
    let dependencies: AppDependencies
    @State private var topPetals: [(EmotionPetal, Int)] = []
    @State private var practices: [Practice] = []

    var body: some View {
        NavigationStack {
            Group {
                if practices.isEmpty && topPetals.isEmpty {
                    ContentUnavailableView(
                        "Your care plan grows with you",
                        systemImage: "cross.case",
                        description: Text("A few check-ins, and practices matched to your frequent states will appear here.")
                    )
                    .foregroundStyle(AppColor.text)
                } else {
                    List {
                        if !topPetals.isEmpty {
                            Section("States that visit often") {
                                ForEach(topPetals, id: \.0) { petal, count in
                                    HStack {
                                        Circle().fill(petal.tint).frame(width: 10, height: 10)
                                        Text(petal.displayName)
                                        Spacer()
                                        Text("\(count)")
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                        }
                        Section("Suggested practices") {
                            ForEach(practices) { practice in
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(practice.name)
                                        .font(.headline)
                                        .foregroundStyle(AppColor.text)
                                    Text(practice.description)
                                        .font(.subheadline)
                                        .foregroundStyle(AppColor.text.opacity(0.7))
                                    Text("~\(practice.duration / 60) min")
                                        .font(.caption)
                                        .foregroundStyle(AppColor.primary)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .background(AppColor.background.ignoresSafeArea())
            .navigationTitle("Care plan")
            .task { await load() }
        }
    }

    private func load() async {
        let checkIns = (try? await dependencies.fetchCheckInHistoryUseCase.execute()) ?? []
        let grouped = Dictionary(grouping: checkIns, by: \.petal)
        topPetals = EmotionPetal.allCases
            .compactMap { petal -> (EmotionPetal, Int)? in
                let count = grouped[petal]?.count ?? 0
                return count > 0 ? (petal, count) : nil
            }
            .sorted { $0.1 > $1.1 }
            .prefix(4)
            .map { $0 }

        let shadeIDs = Set(checkIns.map(\.shadeID))
        var matched: [Practice] = []
        for practice in PracticeCatalog.all {
            if practice.matchedShadeIDs.contains(where: { shadeIDs.contains($0) }) {
                matched.append(practice)
            }
        }
        if matched.isEmpty {
            matched = Array(PracticeCatalog.all.prefix(6))
        }
        practices = Array(matched.prefix(8))
    }
}
