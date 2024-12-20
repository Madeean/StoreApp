//
//  StoreHTTPClient.swift
//  StoreApp
//
//  Created by made reihan on 17/11/24.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidServerResponse
    case decodingError
}

class StoreHTTPClient {
    
    func getProductsByCategory(categoryId: Int) async throws -> [Product] {
        let url = URL.productsByCategory(categoryId: categoryId)
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidServerResponse
        }
        
        do {
            let products = try JSONDecoder().decode([Product].self, from: data)
            return products
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    func getAllCategories() async throws -> [Category] {
        let (data, response) = try await URLSession.shared.data(from: URL.allCategories)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidServerResponse
        }

        guard let categories = try? JSONDecoder().decode([Category].self, from: data) else {
            throw NetworkError.decodingError
        }

        return categories
    }
}
