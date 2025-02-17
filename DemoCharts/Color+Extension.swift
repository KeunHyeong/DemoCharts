//
//  Color.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanHex = hexString.hasPrefix("#") ? String(hexString.dropFirst()) : hexString

        let scanner = Scanner(string: cleanHex)
        scanner.currentIndex = cleanHex.startIndex

        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = Double((rgbValue >> 16) & 0xFF) / 255.0
        let green = Double((rgbValue >> 8) & 0xFF) / 255.0
        let blue = Double(rgbValue & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
    
    public static var deepBlue: Color {
        return Color(hex: "#363062")
        
    }
    
    public static var lightGray: Color {
        return Color(hex: "#6B6B6B")
    }
    
    public static var cyon: Color {
        return Color(hex: "#5BDAA4")
    }
}

