//
//  NetworkService.swift
//  OnlineCatalog
//
//  Created by albik on 12.11.2022.
//

import Foundation

func getProducts() {
    let url = "https://dummyjson.com/products"
    
    guard let url = URL(string: url) else { return }
    URLSession.shared.dataTask(with: url) {data, response, error in
        guard let data = data, let response = response else {
            print(error?.localizedDescription ?? "No error description")
            return
        }
        print(response)
        do {
            let products = try JSONDecoder().decode(Products.self, from: data)
            print(products)
        } catch let error {
            print(error)
        }
    }.resume()
}
