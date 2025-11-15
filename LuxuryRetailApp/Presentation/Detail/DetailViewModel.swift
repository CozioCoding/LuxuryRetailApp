//
//  DetailViewModel.swift
//  LuxuryRetailApp
//
//  Created by user279259 on 12/11/2025.
//

import Foundation
import Observation

@Observable
final class DetailViewModel {
    let id: Int
    var product: Product?
    var loading = false
    var error: String?

    private let repo: ProductRepositorying = ProductRepository()
    init(id: Int) { self.id = id }

    func load() async {
        guard !loading else { return }
        loading = true; defer { loading = false }
        do {
            product = try await repo.product(id: id)
        } catch {
            self.error = "Failed to load product"
        }
    }
}
