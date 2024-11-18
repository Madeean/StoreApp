//
//  Product.swift
//  StoreApp
//
//  Created by made reihan on 18/11/24.
//

import Foundation
struct Product: Codable {
    var id: Int?
    let title: String
    let price: Double
    let description: String
    let images: [URL]?
    let category: Category
    let creationAt: String? // Tambahkan ini jika tidak diperlukan secara eksplisit
    let updatedAt: String?
}
