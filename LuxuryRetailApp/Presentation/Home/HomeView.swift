//
//  HomeView.swift
//  LuxuryRetailApp
//
//  Created by user279259 on 15/11/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var cart: CartStore 

    var body: some View {
        ZStack {
            LuxuryGradient()
                .ignoresSafeArea()

            VStack(spacing: 28) {

                // MARK: - Header
                VStack(spacing: 6) {
                    Text("Maison Étoile")
                        .font(.system(size: 30, weight: .semibold, design: .serif))
                        .tracking(1.0)
                        .foregroundStyle(Color.luxuryAccent)

                    Text("Paris . Milano . Tokyo")
                        .font(.footnote)
                        .foregroundStyle(.white.opacity(0.7))
                }
                .padding(.top, 24)

                // MARK: - Hero card
                ZStack {
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [
                                    .white.opacity(0.15),
                                    .white.opacity(0.05)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 26, style: .continuous)
                                .strokeBorder(.white.opacity(0.15), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.35), radius: 20, y: 10)

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Curated Luxury Selection")
                            .font(.system(size: 18, weight: .semibold, design: .serif))
                            .foregroundStyle(.white)

                        Text("Discover fragrances, jewels and timepieces handpicked for a modern maison.")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.85))
                            .fixedSize(horizontal: false, vertical: true)

                        HStack(spacing: 16) {
                            featurePill(icon: "sparkles", title: "Fragrances")
                            featurePill(icon: "diamond.fill", title: "Jewels")
                            featurePill(icon: "clock.fill", title: "Timepieces")
                        }
                        .padding(.top, 4)
                    }
                    .padding(22)
                }
                .padding(.horizontal)

                // MARK: - CTA
                VStack(spacing: 16) {
                    NavigationLink {
                        CatalogView()
                            .tint(.luxuryAccent)
                    } label: {
                        HStack(spacing: 10) {
                            Image(systemName: "bag.fill")
                            Text("Enter Boutique")
                                .font(.system(size: 16, weight: .semibold, design: .serif))
                        }
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .background(
                            Capsule(style: .continuous)
                                .fill(Color.luxuryAccent)
                        )
                        .foregroundStyle(Color.black)
                        .shadow(color: .black.opacity(0.3), radius: 12, y: 6)
                    }
                    .buttonStyle(.plain)

                    Text("Exclusive pieces, seamless shopping, no checkout required.")
                        .font(.footnote)
                        .foregroundStyle(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }

                Spacer()
            }
            .padding(.bottom, 24)
        }
    }

    private func featurePill(icon: String, title: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 11, weight: .semibold))
            Text(title)
                .font(.system(size: 11, weight: .medium, design: .serif))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            Capsule(style: .continuous)
                .fill(Color.white.opacity(0.15))
        )
        .foregroundStyle(.white.opacity(0.95))
    }
}

