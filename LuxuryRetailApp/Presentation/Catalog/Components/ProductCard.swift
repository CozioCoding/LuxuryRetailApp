//
//  ProductCard.swift
//  LuxuryRetailApp
//
//  Created by user279259 on 12/11/2025.
//

import SwiftUI

struct ProductCard: View {
    let product: Product
    @Environment(\.colorScheme) private var scheme
    @State private var tilt: CGSize = .zero

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack {
                GeometryReader { geo in
                    let url = URL(string: product.thumbnail)
                    CachedAsyncImage(url: url)
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                        .overlay(LinearGradient(colors: [.black.opacity(0.0), .black.opacity(0.25)], startPoint: .center, endPoint: .bottom))
                        .rotation3DEffect(.degrees(Double(tilt.width) / -15), axis: (x: 0, y: 1, z: 0))
                        .rotation3DEffect(.degrees(Double(tilt.height) / 15), axis: (x: 1, y: 0, z: 0))
                }
            }
            .frame(height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .shadow(color: .black.opacity(0.3), radius: 12, y: 6)

            Text(product.brand ?? "—")
                .font(.footnote).foregroundStyle(.white.opacity(0.8)).textCase(.uppercase).tracking(1)

            Text(product.title)
                .font(.system(size: 14, weight: .semibold))
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(
                    maxWidth: .infinity,
                    minHeight: 40,
                    alignment: .topLeading
                )
                .foregroundStyle(.white.opacity(0.8))

            HStack {
                Text("€\(Int(product.price))").bold().foregroundStyle(Color.luxuryAccent)
                Spacer()
                Label("\(String(format: "%.1f", product.rating))", systemImage: "star.fill")
                    .font(.caption).foregroundStyle(.yellow)
            }
        }
        .padding(12)
        .luxuryGlass()
    }
}
