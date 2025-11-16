//
//  CatalogSortOption.swift
//  LuxuryRetailApp
//
//  Created by user279259 on 15/11/2025.
//

import Foundation

enum CatalogSortOption: String, CaseIterable, Identifiable {
    case priceLowToHigh
    case priceHighToLow
    case rating
    case brand

    var id: String { rawValue }

    var label: String {
        switch self {
        case .priceLowToHigh: return "Price: Low to High"
        case .priceHighToLow: return "Price: High to Low"
        case .rating:         return "Rating"
        case .brand:          return "Brand"
        }
    }
}
