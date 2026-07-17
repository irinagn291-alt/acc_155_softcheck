import Foundation

/// Drives the main wheel screen: petal -> shade -> matched practice.
/// Named per the spec's "Naming" convention.
@Observable
@MainActor
final class CheckInViewModel {
    var petalForShadePicker: EmotionPetal?
    private(set) var revealedPractice: Practice?
    private(set) var isSaving = false
    private(set) var errorMessage: String?

    private let checkInUseCase: CheckInUseCase

    init(checkInUseCase: CheckInUseCase) {
        self.checkInUseCase = checkInUseCase
    }

    func selectPetal(_ petal: EmotionPetal) {
        HapticsService.petalOpened()
        petalForShadePicker = petal
    }

    func dismissShadePicker() {
        petalForShadePicker = nil
    }

    func chooseShade(_ shadeID: String, note: String? = nil) async {
        guard let petal = petalForShadePicker else { return }
        isSaving = true
        defer { isSaving = false }

        do {
            let result = try await checkInUseCase.execute(petal: petal, shadeID: shadeID, note: note, at: .now)
            petalForShadePicker = nil
            revealedPractice = result.practice
            HapticsService.practiceRevealed()
        } catch {
            errorMessage = "Could not save your check-in. Please try again."
        }
    }

    func dismissReveal() {
        revealedPractice = nil
    }
}
