//
//  CatalogSkeletonCard.swift
//  LuxuryRetailApp
//
//  Created by user279259 on 15/11/2025.
//

import SwiftUI

struct CatalogSkeletonCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white.opacity(0.12))
                .frame(height: 150)

            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white.opacity(0.15))
                .frame(height: 10)

            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white.opacity(0.12))
                .frame(height: 10)

            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white.opacity(0.12))
                .frame(height: 10)
                .frame(maxWidth: 80, alignment: .leading)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.white.opacity(0.05))
        )
    }
}
