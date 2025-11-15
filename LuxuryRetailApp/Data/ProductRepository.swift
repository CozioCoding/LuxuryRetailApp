//
//  ProductRepository.swift
//  LuxuryRetailApp
//
//  Created by user279259 on 12/11/2025.
//

import Foundation

protocol ProductRepositorying {
    func fetchPage(skip: Int, limit: Int, query: String?) async throws -> PagedProducts
    func product(id: Int) async throws -> Product
}

final class ProductRepository: ProductRepositorying {
    private let api = APIClient()
    func fetchPage(skip: Int, limit: Int, query: String?) async throws -> PagedProducts {
        if let q = query, !q.isEmpty {
            return try await api.get(Endpoints.search(q, skip: skip, limit: limit))
        } else {
            return try await api.get(Endpoints.products(skip: skip, limit: limit))
        }
    }
    func product(id: Int) async throws -> Product {
        try await api.get(Endpoints.product(id: id))
    }
}
