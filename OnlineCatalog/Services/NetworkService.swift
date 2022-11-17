//
//  NetworkService.swift
//  OnlineCatalog
//
//  Created by albik on 12.11.2022.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchProducts(from Url: String, completion: @escaping (Result<[Product], AFError>) -> Void) {
        AF.request (Url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success (let value):
                    let products = Product.getProduct(from: value)
                    completion (.success (products))
                case .failure (let error):
                    completion(.failure (error))
                }
            }
    }
    
    func fetchData(from url: String, completion: @escaping (Result<Data, AFError>) -> Void) {
        AF.request (url)
            .validate ()
            .responseData { dataRequest in
            switch dataRequest.result {
            case .success(let data) :
                completion (.success (data))
            case .failure(let error):
                completion(. failure (error))
            }
        }
    }
}
