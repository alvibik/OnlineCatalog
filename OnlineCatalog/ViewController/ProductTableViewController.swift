//
//  ProductTableViewController.swift
//  OnlineCatalog
//
//  Created by albik on 12.11.2022.
//

import UIKit

final class ProductTableViewController: UITableViewController {
    
    // MARK: - Private properties
    
    private var products: [Product] = []
    
    // MARK: - Override super class methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProducts()
        print(products)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "productCell",
                for: indexPath
            ) as? ProductTableViewCell
        else {
            return UITableViewCell()
        }
        let product = products[indexPath.row]
        cell.configure(with: product)
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "productDetail" { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            let productDetailVC = segue.destination as! ProductDetailViewController
            productDetailVC.product = products[indexPath.row]
        }
    }
}

// MARK: - Extension ProductTableViewController


extension ProductTableViewController {
    
    func fetchProducts() {
        NetworkManager.shared.fetchProducts(from: "https://dummyjson.com/products") { [weak self] result in
            switch result {
            case .success(let products):
                print(products)
                self?.products = products
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
