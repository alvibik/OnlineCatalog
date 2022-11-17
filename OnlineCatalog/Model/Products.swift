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
    let id: Int?
    let title: String?
    let price: Int?
    let rating: Double?
    let description: String?
    let stock: Int?
    let brand: String?
    let category: String?
    let thumbnail: String?
    let images: [String]?
    
    init(id: Int, title: String, price: Int, rating: Double, description: String,
         stock: Int, brand: String, category: String, thumbnail: String, images: [String])
    {
        self.id = id
        self.title = title
        self.price = price
        self.rating = rating
        self.description = description
        self.stock = stock
        self.brand = brand
        self.category = category
        self.thumbnail = thumbnail
        self.images = images
    }
    
    init(productData: [String: Any]) {
        id = productData["id"] as? Int
        title = productData["title"] as? String
        price = productData["price"] as? Int
        rating = productData["rating"] as? Double
        description = productData["description"] as? String
        stock = productData["stock"] as? Int
        brand = productData["brand"] as? String
        category = productData["category"] as? String
        thumbnail = productData["thumbnail"] as? String
        images = productData["images"] as? [String]
    }
    
    static func getProduct(from value: Any) -> [Product] {
        guard let productsData = value as? [String: Any] else { return []}
        guard let productsResult = productsData["products"] as? [[String: Any]] else { return []}

        return productsResult.compactMap{Product(productData: $0)}
    }
}

