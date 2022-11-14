//
//  TestViewController.swift
//  OnlineCatalog
//
//  Created by albik on 14.11.2022.
//

import UIKit

class TestViewController: UIViewController {

    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProducts()
        //fetchProducts()
        print (products)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func getProducts() {
        let url = "https://dummyjson.com/products"
        
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) {data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            //print(response)
            do {
                let result = try JSONDecoder().decode(Products.self, from: data)
                self.products = result.products
                //print(self.products)
            } catch let error {
                print(error)
            }
        }.resume()
    }
//    func fetchProducts() {
//        NetworkManager.shared.fetch(Products.self, from:"https://dummyjson.com/products") { [weak self] result in
//            switch result {
//            case .success(let products):
//                self?.products = products
//                //self?.tableView.reloadData()
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }

}
