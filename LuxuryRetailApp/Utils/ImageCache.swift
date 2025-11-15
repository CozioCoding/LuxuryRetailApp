//
//  ImageCache.swift
//  LuxuryRetailApp
//
//  Created by user279259 on 12/11/2025.
//

//
//  ImageCache.swift
//  LuxuryRetailApp
//

import SwiftUI

actor ImageCache {
    static let shared = ImageCache()
    private var cache: [URL: Image] = [:]

    func image(for url: URL) -> Image? { cache[url] }
    func set(_ image: Image, for url: URL) { cache[url] = image }
}

struct CachedAsyncImage: View {
    let url: URL?

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                Rectangle().fill(Color.white.opacity(0.05))
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                Rectangle().fill(Color.white.opacity(0.05))
            @unknown default:
                Rectangle().fill(Color.white.opacity(0.05))
            }
        }
    }
}


