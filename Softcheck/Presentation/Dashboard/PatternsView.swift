import Charts
import SwiftUI

struct PatternsView: View {
    @State private var viewModel: PatternsViewModel

    init(dependencies: AppDependencies) {
        _viewModel = State(wrappedValue: dependencies.makePatternsViewModel())
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding(.top, 80)
                    } else if !viewModel.hasData {
                        emptyState
                    } else {
                        if let review = viewModel.weeklyReview, review.hasEnoughDataToShow {
                            WeeklyCaringReviewCard(review: review)
                        }

                        frequencyCard
                        distributionCard
                    }
                }
                .padding(20)
            }
            .background(AppColor.background)
            .navigationTitle("Patterns")
        }
        .task { await viewModel.load() }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Spacer(minLength: 60)
            Image(systemName: "leaf")
                .font(.largeTitle)
                .foregroundStyle(AppColor.primary.opacity(0.7))
            Text("Not many notes yet")
                .font(.system(.title3, design: .serif).weight(.semibold))
                .foregroundStyle(AppColor.text)
            Text("A few check-ins, and a quiet, judgment-free overview will appear here.")
                .font(.subheadline)
                .foregroundStyle(AppColor.text.opacity(0.6))
                .multilineTextAlignment(.center)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 28)
    }

    private var frequencyCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Frequency over 14 days")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(AppColor.text.opacity(0.75))

            Chart(viewModel.dailyFrequency) { point in
                BarMark(
                    x: .value("Day", point.date, unit: .day),
                    y: .value("Check-ins", point.count)
                )
                .foregroundStyle(AppColor.primary.opacity(0.75))
                .cornerRadius(4)
            }
            .frame(height: 160)
            .chartXAxis {
                AxisMarks(values: .stride(by: .day, count: 3)) { _ in
                    AxisValueLabel(format: .dateTime.day())
                }
            }
        }
        .padding(18)
        .background(AppColor.surface)
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }

    private var distributionCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("States that showed up")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(AppColor.text.opacity(0.75))

            if viewModel.petalDistribution.isEmpty {
                Text("No petal data yet.")
                    .font(.footnote)
                    .foregroundStyle(AppColor.text.opacity(0.5))
            } else {
                Chart(viewModel.petalDistribution) { point in
                    BarMark(
                        x: .value("Count", point.count),
                        y: .value("State", point.petal.displayName)
                    )
                    .foregroundStyle(point.petal.tint.opacity(0.85))
                    .cornerRadius(4)
                }
                .frame(height: CGFloat(max(120, viewModel.petalDistribution.count * 28)))
            }
        }
        .padding(18)
        .background(AppColor.surface)
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}

#Preview {
    PatternsView(dependencies: PreviewContainer.shared.dependencies)
}
