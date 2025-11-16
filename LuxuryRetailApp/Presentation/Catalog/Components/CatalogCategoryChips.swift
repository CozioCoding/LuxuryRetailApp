//
//  CatalogCategoryChips.swift
//  LuxuryRetailApp
//
//  Created by user279259 on 15/11/2025.
//

import SwiftUI

struct CatalogCategoryChips: View {
    let selectedCategory: CatalogViewModel.FilterCategory
    let onSelect: (CatalogViewModel.FilterCategory) -> Void

    var body: some View {
        HStack(spacing: 8) {
            ForEach(CatalogViewModel.FilterCategory.allCases, id: \.self) { category in
                let isSelected = (selectedCategory == category)

                Button {
                    onSelect(category)
                } label: {
                    Text(shortLabel(for: category))
                        .font(.system(size: 12, weight: .semibold, design: .serif))
                        .tracking(0.8)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .fill(
                                    isSelected
                                    ? Color.white.opacity(0.95)
                                    : Color.white.opacity(0.12)
                                )
                        )
                        .foregroundStyle(
                            isSelected
                            ? Color.black
                            : Color.white.opacity(0.9)
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.white.opacity(0.06))
        )
        .padding(.horizontal)
        .padding(.top, 12)
        .padding(.bottom, 8)
    }

    private func shortLabel(for category: CatalogViewModel.FilterCategory) -> String {
        switch category {
        case .all:        return "All"
        case .fragrances: return "Scents"
        case .watches:    return "Watches"
        case .jewellery:  return "Jewels"
        case .bags:       return "Bags"
        }
    }
}
