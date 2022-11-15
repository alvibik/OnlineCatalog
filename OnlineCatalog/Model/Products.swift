//
//  Products.swift
//  OnlineCatalog
//
//  Created by albik on 12.11.2022.
//
// MARK: - Products
struct Products: Codable {
    let products: [Product]
}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let title: String
    let price: Int
    let rating: Double
    let description: String
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
}

