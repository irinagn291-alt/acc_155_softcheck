import SwiftUI

/// The "moment of outcome" — the petal has opened and a practice matched to
/// the need (not just the mood label) is gently revealed.
struct PracticeRevealSheet: View {
    let practice: Practice
    let onDone: () -> Void

    @State private var showTimedHold = false

    var body: some View {
        VStack(spacing: 24) {
            Capsule()
                .fill(AppColor.secondary.opacity(0.4))
                .frame(width: 36, height: 5)
                .padding(.top, 10)

            Text("What you might need right now")
                .font(.footnote.weight(.semibold))
                .foregroundStyle(AppColor.primary)
                .textCase(.uppercase)

            Image(systemName: practice.category.symbolName)
                .font(.system(size: 40))
                .foregroundStyle(AppColor.primary)
                .padding(24)
                .background(AppColor.primary.opacity(0.12))
                .clipShape(Circle())

            VStack(spacing: 10) {
                Text(practice.name)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(AppColor.text)
                    .multilineTextAlignment(.center)

                Text(practice.description)
                    .font(.body)
                    .foregroundStyle(AppColor.text.opacity(0.75))
                    .multilineTextAlignment(.center)

                Label(practice.durationLabel, systemImage: "clock")
                    .font(.footnote)
                    .foregroundStyle(AppColor.text.opacity(0.5))
                    .padding(.top, 4)
            }
            .padding(.horizontal, 28)

            Spacer()

            VStack(spacing: 12) {
                Button {
                    showTimedHold = true
                } label: {
                    Text("Hold with timer")
                        .font(.body.weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding(16)
                }
                .foregroundStyle(AppColor.primary)
                .background(AppColor.primary.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 22))

                Button(action: onDone) {
                    Text("Okay")
                        .font(.body.weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding(16)
                }
                .foregroundStyle(AppColor.surface)
                .background(AppColor.primary)
                .clipShape(RoundedRectangle(cornerRadius: 22))
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 12)
        }
        .background(AppColor.background)
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.hidden)
        .sheet(isPresented: $showTimedHold) {
            TimedPracticeHoldSheet(practice: practice) {
                showTimedHold = false
                onDone()
            }
        }
    }
}

#Preview {
    PracticeRevealSheet(practice: PracticeCatalog.all[0], onDone: {})
}
