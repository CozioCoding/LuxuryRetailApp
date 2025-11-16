//
//  DetailView.swift
//  LuxuryRetailApp
//
//  Created by user279259 on 12/11/2025.
//

import SwiftUI

struct DetailView: View {
    @State private var vm: DetailViewModel
    @EnvironmentObject var cart: CartStore

    init(id: Int) { _vm = .init(initialValue: DetailViewModel(id: id)) }

    var body: some View {
        ZStack {
            LuxuryGradient()
            Group {
                if let p = vm.product {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            TabView {
                                ForEach(p.images, id: \.self) { url in
                                    CachedAsyncImage(url: URL(string: url))
                                        .scaledToFill()
                                        .frame(height: 340)
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 24))
                                }
                            }
                            .tabViewStyle(.page)
                            .frame(height: 360)

                            Text(p.brand ?? "—").font(.footnote).foregroundStyle(.white.opacity(0.8)).textCase(.uppercase)
                            Text(p.title).font(.title2.bold()).foregroundStyle(.white)

                            HStack {
                                Text("€\(Int(p.price))").font(.title3.bold()).foregroundStyle(Color.luxuryAccent)
                                Spacer()
                                Label(String(format: "%.1f", p.rating), systemImage: "star.fill")
                                    .foregroundStyle(.yellow)
                            }

                            Text(p.description).foregroundStyle(.white.opacity(0.9))

                            Button {
                                cart.add(p)
                            } label: {
                                HStack {
                                    Image(systemName: "bag.fill")
                                        .foregroundStyle(Color.luxuryAccent)
                                    Text("Add to Bag")
                                        .foregroundStyle(Color.luxuryAccent)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 16).fill(Color.luxuryAccent.opacity(0.25)))
                            }
                        }
                        .padding()
                    }
                } else if vm.loading {
                    ProgressView().tint(.luxuryAccent)
                } else if let err = vm.error {
                    Text(err).foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("Product")
        .navigationBarTitleDisplayMode(.inline)
        .task { await vm.load() }
    }
}
