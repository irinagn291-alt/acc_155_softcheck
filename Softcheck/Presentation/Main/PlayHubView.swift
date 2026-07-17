import SwiftUI

struct PlayHubView: View {
    @State private var showHarmony = false
    @State private var showBreath = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 14) {
                    card(
                        title: "Petal Harmony",
                        subtitle: "Rotate soft petals until they rest together.",
                        symbol: "leaf.circle",
                        action: { showHarmony = true }
                    )
                    card(
                        title: "Soft Breath",
                        subtitle: "Follow a gentle pulse — inhale, hold, release.",
                        symbol: "wind",
                        action: { showBreath = true }
                    )
                }
                .padding(20)
            }
            .background(AppColor.background.ignoresSafeArea())
            .navigationTitle("Play")
            .sheet(isPresented: $showHarmony) {
                PetalHarmonyView(onDismiss: { showHarmony = false })
            }
            .sheet(isPresented: $showBreath) {
                SoftBreathView()
            }
        }
    }

    private func card(title: String, subtitle: String, symbol: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: symbol)
                    .font(.title2)
                    .foregroundStyle(AppColor.primary)
                    .frame(width: 44, height: 44)
                VStack(alignment: .leading, spacing: 4) {
                    Text(title).font(.headline).foregroundStyle(AppColor.text)
                    Text(subtitle).font(.subheadline).foregroundStyle(AppColor.text.opacity(0.65))
                }
                Spacer()
                Image(systemName: "chevron.right").foregroundStyle(AppColor.text.opacity(0.35))
            }
            .padding(16)
            .background(AppColor.surface)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    PlayHubView()
}
