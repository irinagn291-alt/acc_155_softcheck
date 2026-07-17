import SwiftUI

/// A single soft, rounded flower petal pointing "up" within its frame —
/// base at the bottom center, tip at the top center.
struct PetalShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height

        path.move(to: CGPoint(x: width / 2, y: height))
        path.addQuadCurve(
            to: CGPoint(x: width / 2, y: 0),
            control: CGPoint(x: width, y: height * 0.28)
        )
        path.addQuadCurve(
            to: CGPoint(x: width / 2, y: height),
            control: CGPoint(x: 0, y: height * 0.28)
        )
        return path
    }
}
