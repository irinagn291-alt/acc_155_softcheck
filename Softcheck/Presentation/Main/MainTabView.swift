import SwiftUI

struct MainTabView: View {
    let dependencies: AppDependencies

    var body: some View {
        TabView {
            MoodWheelView(dependencies: dependencies)
                .tabItem { Label("Now", systemImage: "camera.macro") }

            CareHubView(dependencies: dependencies)
                .tabItem { Label("Care", systemImage: "cross.case") }

            PatternsView(dependencies: dependencies)
                .tabItem { Label("Patterns", systemImage: "chart.bar") }

            SettingsView(dependencies: dependencies)
                .tabItem { Label("Settings", systemImage: "gearshape") }
        }
        .tint(AppColor.accent)
    }
}

#Preview {
    MainTabView(dependencies: PreviewContainer.shared.dependencies)
}
