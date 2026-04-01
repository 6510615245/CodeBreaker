//
//  Color+String.swift
//  CodeBreaker
//
//  Created by นางสาวพลอยพรรณ เต็งประยูร on 1/4/2569 BE.
//

import SwiftUI

extension Color {
    // MARK: - Non-Failable Initializer
    /// Initializes a Color from a Hex string.
    /// Defaults to Color.clear if the string is invalid.
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        let length = hexSanitized.count

        // Ensure we can scan the hex and it's a valid length
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb),
              [3, 6, 8].contains(length) else {
            self = .clear
            return
        }

        let r, g, b, a: Double
        
        switch length {
        case 3: // RGB (12-bit) - e.g. "F00"
            r = Double((rgb & 0xF00) >> 8) / 15.0
            g = Double((rgb & 0x0F0) >> 4) / 15.0
            b = Double(rgb & 0x00F) / 15.0
            a = 1.0
        case 6: // RGB (24-bit) - e.g. "FF0000"
            r = Double((rgb & 0xFF0000) >> 16) / 255.0
            g = Double((rgb & 0x00FF00) >> 8) / 255.0
            b = Double(rgb & 0x0000FF) / 255.0
            a = 1.0
        case 8: // ARGB (32-bit) - e.g. "FFFF0000"
            r = Double((rgb & 0xFF000000) >> 24) / 255.0
            g = Double((rgb & 0x00FF0000) >> 16) / 255.0
            b = Double((rgb & 0x0000FF00) >> 8) / 255.0
            a = Double(rgb & 0x000000FF) / 255.0
        default:
            self = .clear
            return
        }

        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }

    // MARK: - Computed Property
    /// Converts Color to Hex string.
    /// Returns an empty string "" if components cannot be extracted.
    var hex: String {
        #if canImport(UIKit)
        let nativeColor = UIColor(self)
        #elseif canImport(AppKit)
        let nativeColor = NSColor(self)
        #endif

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        guard nativeColor.getRed(&r, green: &g, blue: &b, alpha: &a) else {
            return ""
        }

        // Return with Alpha if the color is not fully opaque
        if a < 1.0 {
            return String(format: "#%02X%02X%02X%02X",
                          Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
        } else {
            return String(format: "#%02X%02X%02X",
                          Int(r * 255), Int(g * 255), Int(b * 255))
        }
    }
}
