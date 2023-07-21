//
//  SwiftUIView.swift
//  
//
//  Created by minghui on 2022/7/7.
//

import SwiftUI

extension Color {
    public init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    public static let grayF2 = Color(hex: "#F2F2F2")
    public static let gray100 = Color(hex: "#F4F4F5")
    public static let gray200 = Color(hex: "#E5E5E5")
    public static let gray300 = Color(hex: "#D4D4D8")
    public static let gray400 = Color(hex: "#A1A1AA")
    public static let gray500 = Color(hex: "#71717A")
    public static let gray600 = Color(hex: "#52525B")
    public static let gray700 = Color(hex: "#3F3F46")
    public static let gray800 = Color(hex: "#27272A")
    
    public static let green100 = Color(hex: "#DCFCE7")
    public static let green200 = Color(hex: "#5AD91E")
    public static let green500 = Color(hex: "#22C55E")
    
    public static let rose200 = Color(hex: "#FECDD3")
    public static let rose500 = Color(hex: "#F43F51")
    public static let redWrong = Color(hex: "#FF5858")
}
