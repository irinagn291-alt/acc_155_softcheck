import SwiftUI

struct MainTabView: View {
    let dependencies: AppDependencies

    private enum Tab: Hashable {
        case now, care, patterns, settings
    }

    @State private var tab: Tab = .now

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch tab {
                case .now:
                    MoodWheelView(dependencies: dependencies)
                case .care:
                    CareHubView(dependencies: dependencies)
                case .patterns:
                    PatternsView(dependencies: dependencies)
                case .settings:
                    SettingsView(dependencies: dependencies)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            Divider()

            HStack(spacing: 0) {
                tabButton(.now, title: "Now", systemImage: "camera.macro")
                tabButton(.care, title: "Care", systemImage: "cross.case")
                tabButton(.patterns, title: "Patterns", systemImage: "chart.bar")
                tabButton(.settings, title: "Settings", systemImage: "gearshape")
            }
            .padding(.top, 8)
            .padding(.bottom, 6)
            .background(AppColor.surface.ignoresSafeArea(edges: .bottom))
        }
        .tint(AppColor.accent)
        .background(AppColor.background.ignoresSafeArea())
    }

    private func tabButton(_ value: Tab, title: String, systemImage: String) -> some View {
        Button {
            tab = value
        } label: {
            VStack(spacing: 4) {
                Image(systemName: systemImage)
                    .font(.system(size: 20, weight: .regular))
                Text(title)
                    .font(.caption2.weight(.medium))
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(tab == value ? AppColor.accent : AppColor.text.opacity(0.45))
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(tab == value ? .isSelected : [])
    }
}

#Preview {
    MainTabView(dependencies: PreviewContainer.shared.dependencies)
}
