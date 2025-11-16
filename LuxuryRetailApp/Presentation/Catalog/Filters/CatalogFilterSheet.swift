//
//  CatalogFilterSheet.swift
//  LuxuryRetailApp
//
//  Created by user279259 on 15/11/2025.
//

import SwiftUI

struct CatalogFilterSheet: View {
    @Binding var sortOption: CatalogSortOption
    @Binding var priceRange: ClosedRange<Double>

    let maxPrice: Double
    let onReset: () -> Void
    let onDone: () -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section("Sort by") {
                    Picker("Sort by", selection: $sortOption) {
                        ForEach(CatalogSortOption.allCases) { option in
                            Text(option.label).tag(option)
                        }
                    }
                    .pickerStyle(.inline)
                }

                Section("Price range") {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("€\(Int(priceRange.lowerBound)) – €\(Int(priceRange.upperBound))")
                            .font(.subheadline)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Min")
                                .font(.caption)
                            Slider(
                                value: Binding(
                                    get: { priceRange.lowerBound },
                                    set: { newValue in
                                        priceRange = min(newValue, priceRange.upperBound)...priceRange.upperBound
                                    }
                                ),
                                in: 0...maxPrice
                            )
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Max")
                                .font(.caption)
                            Slider(
                                value: Binding(
                                    get: { priceRange.upperBound },
                                    set: { newValue in
                                        priceRange = priceRange.lowerBound...max(newValue, priceRange.lowerBound)
                                    }
                                ),
                                in: 0...maxPrice
                            )
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Filters")
            .toolbarBackground(.white, for: .navigationBar)
            .toolbarColorScheme(.light, for: .navigationBar)
            .tint(.black)
            
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Reset") {
                        onReset()
                    }
                    .foregroundStyle(Color.black)
                    .font(.system(size: 14, weight: .semibold, design: .serif))
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        onDone()
                    }
                    .foregroundStyle(Color.black)
                    .font(.system(size: 16, weight: .semibold, design: .serif))
                }
            }
        }
    }
}
