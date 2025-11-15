//
//  CatalogView.swift
//  LuxuryRetailApp
//

import SwiftUI

struct CatalogView: View {
    @State private var vm = CatalogViewModel()
    @Environment(CartStore.self) private var cart

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
                    // Category chips
                    categoryChips

                    // Product grid
                    ScrollView {
                        LazyVGrid(
                            columns: columns,
                            spacing: 16
                        ) {
                            ForEach(vm.items) { item in
                                NavigationLink(value: item.id) {
                                    ProductCard(product: item)
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
                    }
                }
            }
            .navigationTitle("Maison Étoile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    CartButton()
                }
            }
            .searchable(text: $vm.query, prompt: "Search brand or product")
            .onChange(of: vm.query) { _, _ in
                Task { await vm.refresh() }
            }
            .onChange(of: vm.category) { _, _ in
                Task { await vm.refresh() }
            }
            .task {
                await vm.refresh()
            }
            .navigationDestination(for: Int.self) { id in
                DetailView(id: id)
            }
        }
    }

    // MARK: - Category chips

    private var categoryChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(CatalogViewModel.FilterCategory.allCases, id: \.self) { c in
                    let isSelected = (vm.category == c)

                    Button {
                        vm.category = c
                    } label: {
                        Text(shortLabel(for: c))
                            .font(.caption.weight(.medium))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                Capsule(style: .continuous)
                                    .fill(isSelected
                                          ? Color.white.opacity(0.95)
                                          : Color.white.opacity(0.15))
                            )
                            .foregroundStyle(
                                isSelected
                                ? Color.black
                                : Color.white.opacity(0.85)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            .padding(.bottom, 4)
        }
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
