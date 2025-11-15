//
//  CatalogViewModel.swift
//  LuxuryRetailApp
//

import SwiftUI
import Observation

@Observable
final class CatalogViewModel {

    // MARK: - Categories (UI segmented control)
    enum FilterCategory: String, CaseIterable, Hashable {
        case all
        case fragrances
        case watches
        case jewellery
        case bags
    }

    // MARK: - State
    var category: FilterCategory = .all
    var items: [Product] = []
    var query: String = ""

    private var skip = 0
    private let limit = 20
    private var loading = false
    private var canLoadMore = true

    private let repo: ProductRepositorying = ProductRepository()

    // MARK: - Category configuration

    /// All DummyJSON categories we consider "luxury" for the app.
    private let luxuryCategories: Set<String> = [
        "beauty",
        "fragrances",
        "skin-care",
        "womens-bags",
        "womens-jewellery",
        "mens-watches",
        "womens-watches",
        "sunglasses"
    ]

    /// Mapping from UI segmented filter to DummyJSON category slugs.
    /// `.all` is handled separately and shows all `luxuryCategories`.
    private let segmentedCategoryMapping: [FilterCategory: Set<String>] = [
        .fragrances: ["fragrances"],
        .watches:    ["mens-watches", "womens-watches"],
        .jewellery:  ["womens-jewellery"],
        .bags:       ["womens-bags"]
    ]

    // MARK: - Refresh & Pagination

    /// Reset pagination and keep fetching pages until we actually have some items
    /// for the current category (or the API is exhausted).
    func refresh() async {
        skip = 0
        canLoadMore = true
        items = []

        repeat {
            await loadNext()
        } while items.isEmpty && canLoadMore
    }

    func loadMoreIfNeeded(current item: Product) async {
        guard let last = items.last,
              last.id == item.id else { return }
        await loadNext()
    }

    private func loadNext() async {
        guard !loading, canLoadMore else { return }

        loading = true
        defer { loading = false }

        do {
            let page = try await repo.fetchPage(
                skip: skip,
                limit: limit,
                query: query.isEmpty ? nil : query
            )

            // If the API returns no more products at all, stop paginating.
            if page.products.isEmpty {
                canLoadMore = false
                return
            }

            // Filter API data into "luxury-only" + current UI category
            let filtered = page.products.filter { product in
                isLuxury(product) && matchesCategory(product)
            }

            if skip == 0 {
                items = filtered
            } else {
                items += filtered
            }

            skip += limit
        } catch {
            print("Load error:", error)
            canLoadMore = false
        }
    }

    // MARK: - Luxury Filtering

    /// Universal luxury filter based on DummyJSON category slug.
    private func isLuxury(_ product: Product) -> Bool {
        guard let cat = product.category?.lowercased() else { return false }
        return luxuryCategories.contains(cat)
    }

    // MARK: - Category Matching (UI segmented control)

    private func matchesCategory(_ product: Product) -> Bool {
        // "All" tab = any luxury product (already filtered by `isLuxury`)
        guard category != .all else { return true }

        guard let cat = product.category?.lowercased() else { return false }

        let allowedCats = segmentedCategoryMapping[category] ?? []
        return allowedCats.contains(cat)
    }
}
