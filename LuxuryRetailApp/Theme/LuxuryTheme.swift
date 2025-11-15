//
//  LuxuryTheme.swift
//  LuxuryRetailApp
//
//  Created by user279259 on 12/11/2025.
//

import SwiftUI

extension Color {
    static let luxuryBackground = Color(.sRGB, red: 0.06, green: 0.06, blue: 0.07, opacity: 1)
    static let luxuryCard       = Color.white.opacity(0.08)
    static let luxuryAccent     = Color(red: 0.90, green: 0.78, blue: 0.50) // gold
    static let luxuryText       = Color.white
}

struct LuxuryGlass: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .strokeBorder(Color.white.opacity(0.12), lineWidth: 1)
            )
    }
}

extension View {
    func luxuryGlass() -> some View { modifier(LuxuryGlass()) }
}

struct LuxuryGradient: View {
    var body: some View {
        LinearGradient(colors: [
            .luxuryBackground, .luxuryBackground.opacity(0.95),
            .luxuryBackground.opacity(0.9)
        ], startPoint: .topLeading, endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
}
