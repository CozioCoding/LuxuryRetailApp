//
//  CatalogView.swift
//  LuxuryRetailApp
//
//  Created by user279259 on 15/11/2025.
//

import SwiftUI

struct CatalogView: View {
    @State private var vm = CatalogViewModel()
    @Environment(CartStore.self) private var cart

    @State private var showFilters = false
    @State private var sortOption: CatalogSortOption = .priceLowToHigh

    @State private var maxPrice: Double = 500
    @State private var priceRange: ClosedRange<Double> = 0...500

    @State private var isRefreshing = false

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                LuxuryGradient()
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    CatalogCategoryChips(
                        selectedCategory: vm.category,
                        onSelect: { vm.category = $0 }
                    )

                    content
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Maison Étoile")
                        .font(.system(size: 22, weight: .semibold, design: .serif))
                        .tracking(1.0)
                        .foregroundStyle(Color.luxuryAccent)
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showFilters = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .imageScale(.medium)
                    }
                    .foregroundStyle(.white)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    CartButton()
                }
            }
            .searchable(text: $vm.query, prompt: "Search brand or product")
            .onChange(of: vm.query) { _, _ in
                refresh()
            }
            .onChange(of: vm.category) { _, _ in
                refresh()
            }
            .onChange(of: vm.items) { _, newValue in
                let max = newValue.map { $0.price }.max() ?? 500
                maxPrice = max
                if priceRange.upperBound < max {
                    priceRange = priceRange.lowerBound...max
                }
            }
            .task {
                refresh()
            }
            .sheet(isPresented: $showFilters) {
                CatalogFilterSheet(
                    sortOption: $sortOption,
                    priceRange: $priceRange,
                    maxPrice: maxPrice,
                    onReset: {
                        sortOption = .priceLowToHigh
                        priceRange = 0...maxPrice
                    },
                    onDone: {
                        showFilters = false
                    }
                )
            }
            .navigationDestination(for: Int.self) { id in
                DetailView(id: id)
            }
        }
    }

    // MARK: - Content

    @ViewBuilder
    private var content: some View {
        if isRefreshing && vm.items.isEmpty {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(0..<6, id: \.self) { _ in
                        CatalogSkeletonCard()
                            .transition(.opacity.combined(with: .scale))
                    }
                }
                .padding()
            }
        } else if filteredAndSortedItems.isEmpty {
            VStack(spacing: 12) {
                Image(systemName: "bag")
                    .font(.system(size: 40))
                    .foregroundStyle(.white.opacity(0.9))
                Text("No products match your filters.")
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.9))
                Button("Clear filters") {
                    sortOption = .priceLowToHigh
                    priceRange = 0...maxPrice
                    refresh()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.top, 80)
        } else {
            ScrollView {
                LazyVGrid(
                    columns: columns,
                    spacing: 16
                ) {
                    ForEach(filteredAndSortedItems) { item in
                        NavigationLink(value: item.id) {
                            ProductCard(product: item)
                                .transition(.opacity.combined(with: .scale))
                        }
                        .buttonStyle(.plain)
                        .contextMenu {
                            Button("Add to Bag") { cart.add(item) }
                        }
                        .task {
                            await vm.loadMoreIfNeeded(current: item)
                        }
                    }
                }
                .padding()
                .animation(.spring(response: 0.4, dampingFraction: 0.8), value: filteredAndSortedItems.count)
            }
        }
    }

    // MARK: - Filters logic

    private var filteredAndSortedItems: [Product] {
        let inPriceRange = vm.items.filter { product in
            let price = product.price
            return price >= priceRange.lowerBound && price <= priceRange.upperBound
        }

        switch sortOption {
        case .priceLowToHigh:
            return inPriceRange.sorted { $0.price < $1.price }
        case .priceHighToLow:
            return inPriceRange.sorted { $0.price > $1.price }
        case .rating:
            return inPriceRange.sorted { $0.rating > $1.rating }
        case .brand:
            return inPriceRange.sorted {
                ($0.brand ?? "").localizedCaseInsensitiveCompare($1.brand ?? "") == .orderedAscending
            }
        }
    }

    // MARK: - Refresh helper

    private func refresh() {
        isRefreshing = true
        Task {
            await vm.refresh()
            isRefreshing = false
        }
    }
}
