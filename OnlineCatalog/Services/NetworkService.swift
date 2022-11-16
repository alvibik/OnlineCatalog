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
    
    func fetchProducts (from Url: String, completion: @escaping (Result<[Product], AFError>) -> Void) {
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
    
    func fetch<T: Decodable>(_ type: T.Type, from url: String?, completion: @escaping(Result<T,NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
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
    
    /*
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    } */
}
