import SwiftUI

struct CareHubView: View {
    let dependencies: AppDependencies

    private enum Section: String, CaseIterable, Identifiable {
        case plan = "Plan"
        case history = "History"
        case grounding = "Grounding"
        case play = "Play"
        var id: String { rawValue }
    }

    @State private var section: Section = .plan

    var body: some View {
        Group {
            switch section {
            case .plan: CarePlanView(dependencies: dependencies)
            case .history: CheckInHistoryView(dependencies: dependencies)
            case .grounding: GroundingShelfView()
            case .play: PlayHubView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            sectionPicker
        }
        .background(AppColor.background.ignoresSafeArea())
    }

    private var sectionPicker: some View {
        Picker("Section", selection: $section) {
            ForEach(Section.allCases) { item in
                Text(item.rawValue).tag(item)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .frame(maxWidth: 720)
        .frame(maxWidth: .infinity)
        .background(AppColor.surface.opacity(0.98))
    }
}
