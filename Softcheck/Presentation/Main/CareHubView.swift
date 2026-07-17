import SwiftUI

struct CareHubView: View {
    let dependencies: AppDependencies

    private enum Section: String, CaseIterable, Identifiable {
        case care = "Care"
        case history = "History"
        case grounding = "Grounding"
        case play = "Play"
        var id: String { rawValue }
    }

    @State private var section: Section = .care

    var body: some View {
        VStack(spacing: 0) {
            Picker("Section", selection: $section) {
                ForEach(Section.allCases) { item in
                    Text(item.rawValue).tag(item)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)

            Group {
                switch section {
                case .care: CarePlanView(dependencies: dependencies)
                case .history: CheckInHistoryView(dependencies: dependencies)
                case .grounding: GroundingShelfView()
                case .play: PlayHubView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(AppColor.background)
    }
}