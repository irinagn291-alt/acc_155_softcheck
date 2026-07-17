import SwiftUI

struct CheckInHistoryView: View {
    let dependencies: AppDependencies
    @State private var checkIns: [MoodCheckIn] = []

    var body: some View {
        NavigationStack {
            Group {
                if checkIns.isEmpty {
                    ContentUnavailableView(
                        "No notes yet",
                        systemImage: "list.bullet.rectangle",
                        description: Text("Each check-in becomes a quiet line in your history.")
                    )
                    .foregroundStyle(AppColor.text)
                } else {
                    List(checkIns) { item in
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Circle().fill(item.petal.tint).frame(width: 10, height: 10)
                                Text(item.petal.displayName)
                                    .font(.headline)
                                Spacer()
                                Text(item.timestamp.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            if let note = item.note, !note.isEmpty {
                                Text(note)
                                    .font(.subheadline)
                                    .foregroundStyle(AppColor.text.opacity(0.8))
                            }
                            if let practiceID = item.matchedPracticeID,
                               let practice = PracticeCatalog.practice(id: practiceID) {
                                Text(practice.name)
                                    .font(.caption)
                                    .foregroundStyle(AppColor.primary)
                            }
                        }
                        .padding(.vertical, 2)
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .background(AppColor.background.ignoresSafeArea())
            .navigationTitle("History")
            .task {
                let all = (try? await dependencies.fetchCheckInHistoryUseCase.execute()) ?? []
                checkIns = all.sorted { $0.timestamp > $1.timestamp }
            }
        }
    }
}
