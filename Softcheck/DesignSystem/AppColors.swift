import SwiftUI

extension Color {
    init(hex: String) {
        let cleaned = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: cleaned).scanHexInt64(&rgb)
        let r = Double((rgb & 0xFF0000) >> 16) / 255
        let g = Double((rgb & 0x00FF00) >> 8) / 255
        let b = Double(rgb & 0x0000FF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

/// Design tokens for Softcheck, sourced from the concept's Visual Direction spec.
enum AppColor {
    static let primary = Color(hex: "#9D8DF1")
    static let secondary = Color(hex: "#B8C0FF")
    static let accent = Color(hex: "#FFC2D1")
    static let background = Color(hex: "#FBFAFF")
    static let surface = Color(hex: "#FFFFFF")
    static let text = Color(hex: "#3A3550")
}
