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

    func refresh() async {
        skip = 0
        canLoadMore = true
        items = []
        await loadNext()
    }

    func loadMoreIfNeeded(current item: Product) async {
        guard let last = items.last,
              last.id == item.id else { return }
        await loadNext()
    }

    /// Fetches next pages until:
    /// - we actually get some new items for the current filter, or
    /// - the API runs out of products.
    private func loadNext() async {
        guard !loading, canLoadMore else { return }

        loading = true
        defer { loading = false }

        var accumulated: [Product] = []
        var localSkip = skip

        do {
            // Keep pulling pages until we get at least one item for this filter,
            // or until DummyJSON has no more products.
            while canLoadMore, accumulated.isEmpty {
                let page = try await repo.fetchPage(
                    skip: localSkip,
                    limit: limit,
                    query: query.isEmpty ? nil : query
                )

                // No more products at all → stop paginating.
                if page.products.isEmpty {
                    canLoadMore = false
                    break
                }

                let filtered = page.products.filter { product in
                    isLuxury(product) && matchesCategory(product)
                }

                accumulated.append(contentsOf: filtered)
                localSkip += limit
            }

            // If we found nothing new, just stop here (no UI update).
            guard !accumulated.isEmpty else { return }

            if skip == 0 && items.isEmpty {
                items = accumulated
            } else {
                items += accumulated
            }

            // Advance global skip to where our local loop ended.
            skip = localSkip

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
