import SwiftData

/// In-memory `AppDependencies` factory for SwiftUI previews only.
@MainActor
struct PreviewContainer {
    static let shared = PreviewContainer()

    let dependencies: AppDependencies

    private init() {
        let schema = Schema(AppSchema.allModels)
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        do {
            let container = try ModelContainer(for: schema, configurations: [configuration])
            dependencies = AppDependencies(modelContext: container.mainContext)
        } catch {
            fatalError("Could not create preview ModelContainer: \(error)")
        }
    }
}
