//
//  APIClient.swift
//  LuxuryRetailApp
//
//  Created by user279259 on 12/11/2025.
//

import Foundation

enum APIError: Error { case invalidURL, transport(Error), badStatus(Int), decode(Error) }

final class APIClient {
    private let base = URL(string: "https://dummyjson.com")!
    private let session: URLSession = .shared
    
    func get<T: Decodable>(_ endpoint: Endpoint<T>) async throws -> T {
        guard var comps = URLComponents(url: base.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false) else {
            throw APIError.invalidURL
        }
        if !endpoint.query.isEmpty { comps.queryItems = endpoint.query.map { URLQueryItem(name: $0.key, value: "\($0.value)") } }
        guard let url = comps.url else { throw APIError.invalidURL }
        
        let (data, resp): (Data, URLResponse)
        do { (data, resp) = try await session.data(from: url) }
        catch { throw APIError.transport(error) }
        
        guard let http = resp as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            let code = (resp as? HTTPURLResponse)?.statusCode ?? -1
            throw APIError.badStatus(code)
        }
        do { return try JSONDecoder().decode(T.self, from: data) }
        catch { throw APIError.decode(error) }
    }
}
