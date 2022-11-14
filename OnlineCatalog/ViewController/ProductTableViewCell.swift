//
//  ProductTVCell.swift
//  OnlineCatalog
//
//  Created by albik on 14.11.2022.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    //private var products: [Product] = []

    @IBOutlet var productThumbnailImage: UIImageView!
    @IBOutlet var productTitleLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    @IBOutlet var productDiscountLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    func configure(with product: Product) {
        productTitleLabel.text = product.title
        productPriceLabel.text = "Price: \(product.price) $"
        productDiscountLabel.text = "⭐️ \(product.rating) out of 5 "
        
        NetworkManager.shared.fetchImage(from: product.thumbnail) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.productThumbnailImage.image = UIImage(data: imageData)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
        
//        func getProducts() {
//            let url = "https://dummyjson.com/products"
//            
//            guard let url = URL(string: url) else { return }
//            URLSession.shared.dataTask(with: url) {data, _, error in
//                guard let data = data else {
//                    print(error?.localizedDescription ?? "No error description")
//                    return
//                }
//                //print(response)
//                do {
//                    let products = try JSONDecoder().decode(Products.self, from: data)
//                    self.products = products.products
//                    //self.tableView.reloadData()
//                    print(products.products)
//                } catch let error {
//                    print(error)
//                }
//            }.resume()
//        }
        
//        func getProducts() {
//            let url = "https://dummyjson.com/products"
//
//            guard let url = URL(string: url) else { return }
//            URLSession.shared.dataTask(with: url) {data, _, error in
//                guard let data = data else {
//                    print(error?.localizedDescription ?? "No error description")
//                    return
//                }
//                //print(response)
//                do {
//                    let products = try JSONDecoder().decode(Products.self, from: data)
//                    self.products = products.products
//                    //self.tableView.reloadData()
//                    //print(products.products)
//                } catch let error {
//                    print(error)
//                }
//            }.resume()
//        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
