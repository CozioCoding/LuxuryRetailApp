//
//  CartButton.swift
//  LuxuryRetailApp
//
//  Created by user279259 on 12/11/2025.
//
import SwiftUI

struct CartButton: View {
    @EnvironmentObject var cart: CartStore

    var body: some View {
        NavigationLink {
            CartView()
        } label: {
            HStack(spacing: 6) {
                Image(systemName: "bag.fill").imageScale(.medium)
                if cart.lines.count > 0 {
                    Text("\(cart.lines.count)")
                        .font(.caption2)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Capsule().fill(Color.luxuryAccent.opacity(0.25)))
                }
            }
        }
        .foregroundStyle(.white)
    }
}
