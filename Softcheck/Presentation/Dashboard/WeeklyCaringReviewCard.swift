import SwiftUI

/// The "quiet weekly caring review" hook — a soft, descriptive recap with
/// no streaks, no scores, no good/bad framing.
struct WeeklyCaringReviewCard: View {
    let review: WeeklyCaringReview

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("A quiet look at your week", systemImage: "sparkles")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(AppColor.primary)

            Text(review.careNote)
                .font(.body)
                .foregroundStyle(AppColor.text.opacity(0.8))
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColor.surface)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .shadow(color: AppColor.text.opacity(0.05), radius: 10, y: 4)
    }
}

#Preview {
    WeeklyCaringReviewCard(
        review: WeeklyCaringReview(
            checkInCount: 4,
            mostFrequentPetal: .calm,
            distinctShadeCount: 3,
            mostUsedPractice: PracticeCatalog.all.first
        )
    )
    .padding()
    .background(AppColor.background)
}
