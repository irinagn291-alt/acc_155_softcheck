import SwiftUI

/// Region-agnostic crisis-resources section, required by the spec's
/// compliance notes. Deliberately does not hardcode any one country's
/// hotline number — it points the user toward local emergency/crisis support.
struct CrisisResourcesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("If things feel truly hard right now", systemImage: "cross.case")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(AppColor.text)

            Text("Softcheck is not a substitute for therapy or emergency care. It is simply a gentle tool for everyday self-reflection.")
                .font(.footnote)
                .foregroundStyle(AppColor.text.opacity(0.75))

            Text("If you or someone nearby is in danger, or thoughts have become unbearable — please reach out to local emergency services or a mental health crisis line in your country. You do not have to go through this alone.")
                .font(.footnote)
                .foregroundStyle(AppColor.text.opacity(0.75))
        }
        .padding(16)
        .background(AppColor.accent.opacity(0.16))
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}

#Preview {
    CrisisResourcesView()
        .padding()
        .background(AppColor.background)
}
