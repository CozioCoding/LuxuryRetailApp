//
//  PagedProducts.swift
//  LuxuryRetailApp
//
//  Created by user279259 on 12/11/2025.
//

import Foundation

struct PagedProducts: Decodable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}
