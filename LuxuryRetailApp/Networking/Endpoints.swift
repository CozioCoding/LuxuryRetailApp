//
//  Endpoints.swift
//  LuxuryRetailApp
//
//  Created by user279259 on 12/11/2025.
//

import Foundation

struct Endpoint<T: Decodable> {
    let path: String
    let query: [String: Any]
    init(path: String, query: [String: Any] = [:]) { self.path = path; self.query = query }
}

enum Endpoints {
    static func products(skip: Int, limit: Int) -> Endpoint<PagedProducts> {
        .init(path: "products", query: ["skip": skip, "limit": limit])
    }
    static func search(_ q: String, skip: Int, limit: Int) -> Endpoint<PagedProducts> {
        .init(path: "products/search", query: ["q": q, "skip": skip, "limit": limit])
    }
    static func product(id: Int) -> Endpoint<Product> {
        .init(path: "products/\(id)")
    }
}
