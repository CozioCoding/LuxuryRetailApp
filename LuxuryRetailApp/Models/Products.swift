//
//  Products.swift
//  LuxuryRetailApp
//
//  Created by user279259 on 12/11/2025.
//

import Foundation

struct Product: Identifiable, Decodable, Hashable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double?
    let rating: Double
    let stock: Int?
    let brand: String?
    let category: String?
    let thumbnail: String
    let images: [String]
}

