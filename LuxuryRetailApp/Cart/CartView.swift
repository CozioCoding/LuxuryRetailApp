//
//  CartView.swift
//  LuxuryRetailApp
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cart: CartStore

    var body: some View {
        ZStack {
            LuxuryGradient()

            if cart.lines.isEmpty {
                EmptyBagView()
            } else {
                VStack(spacing: 0) {
                    ScrollView {
                        LazyVStack(spacing: 14) {
                            ForEach(cart.lines) { line in
                                CartLineCard(line: line)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.vertical, 20)
                    }

                    VStack(spacing: 14) {
                        Divider().overlay(Color.white.opacity(0.2))
                        HStack {
                            Text("Total")
                                .font(.headline)
                                .foregroundStyle(.white)
                            Spacer()
                            Text("€\(Int(cart.total))")
                                .font(.headline.bold())
                                .monospacedDigit()
                                .foregroundStyle(Color.luxuryAccent)
                        }

                        Button {
                            // checkout logic
                        } label: {
                            Text("Proceed to Checkout")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(RoundedRectangle(cornerRadius: 16).fill(Color.luxuryAccent))
                                .foregroundStyle(.black)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 25)
                    .background(.ultraThinMaterial)
                }
            }
        }
        .navigationTitle("Your Bag")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(.clear, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .tint(.white)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Clear") { cart.clear() }
                    .disabled(cart.lines.isEmpty)
            }
        }
    }
}

private struct CartLineCard: View {
    @EnvironmentObject var cart: CartStore
    let line: CartStore.Line

    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            // Thumbnail
            AsyncImage(url: URL(string: line.product.thumbnail)) { phase in
                if case .success(let image) = phase {
                    image.resizable().scaledToFill()
                } else {
                    Rectangle().fill(Color.white.opacity(0.1))
                }
            }
            .frame(width: 70, height: 70)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 3)

            // Info + controls
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(line.product.title)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                    Text(line.product.brand ?? "—")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.6))
                }

                // Quantity + price line
                HStack(alignment: .center) {
                    QtyStepper(
                        quantity: Binding(
                            get: { line.qty },
                            set: { new in
                                if new == 0 {
                                    cart.remove(line)
                                } else if let idx = cart.lines.firstIndex(where: { $0.id == line.id }) {
                                    cart.lines[idx].qty = new
                                }
                            }
                        ),
                        range: 0...9
                    )

                    Spacer(minLength: 12)

                    Text("€\(Int(line.lineTotal))")
                        .font(.subheadline.bold())
                        .monospacedDigit()
                        .foregroundStyle(Color.luxuryAccent)
                        .frame(minWidth: 60, alignment: .trailing)
                }
                .padding(.top, 2)
            }
        }
        .padding(12)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.white.opacity(0.1))
        )
    }
}

private struct QtyStepper: View {
    @Binding var quantity: Int
    let range: ClosedRange<Int>

    var body: some View {
        HStack(spacing: 8) {
            Button {
                quantity = max(range.lowerBound, quantity - 1)
            } label: {
                Image(systemName: "minus")
                    .font(.system(size: 12, weight: .bold))
                    .frame(width: 24, height: 24)
            }
            .disabled(quantity <= range.lowerBound)
            .opacity(quantity <= range.lowerBound ? 0.4 : 1)

            Text("\(quantity)")
                .font(.callout.bold())
                .foregroundStyle(.white)
                .frame(width: 22)

            Button {
                quantity = min(range.upperBound, quantity + 1)
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 12, weight: .bold))
                    .frame(width: 24, height: 24)
            }
            .disabled(quantity >= range.upperBound)
            .opacity(quantity >= range.upperBound ? 0.4 : 1)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
        .background(Capsule().fill(Color.white.opacity(0.08)))
        .overlay(
            Capsule().strokeBorder(Color.white.opacity(0.15), lineWidth: 1)
        )
    }
}
	

private struct EmptyBagView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "bag")
                .font(.system(size: 40))
                .foregroundStyle(.white.opacity(0.8))
            Text("Your bag is empty")
                .font(.headline)
                .foregroundStyle(.white)
            Text("Browse products and add your favorites.")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.6))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
