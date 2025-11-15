//
//  CartStore.swift
//  LuxuryRetailApp
//
//  Created by user279259 on 12/11/2025.
//

import Foundation
import Observation

@Observable
final class CartStore {
    struct Line: Identifiable, Hashable {
        let id = UUID()
        let product: Product
        var qty: Int
        var lineTotal: Double { Double(qty) * product.price }
    }
    var lines: [Line] = []
    var total: Double { lines.reduce(0) { $0 + $1.lineTotal } }

    func add(_ product: Product) {
        if let idx = lines.firstIndex(where: { $0.product.id == product.id }) {
            lines[idx].qty += 1
        } else {
            lines.append(.init(product: product, qty: 1))
        }
    }
    func remove(_ line: Line) { lines.removeAll { $0.id == line.id } }
    func clear() { lines.removeAll() }
}
