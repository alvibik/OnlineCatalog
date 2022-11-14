//
//  ViewController.swift
//  OnlineCatalog
//
//  Created by albik on 12.11.2022.
//

import UIKit

final class ProductDetailViewController: UIViewController {
    
    //MARK: - Public properties
  
    var product: Product!
    
    //MARK: - IBOutlets
    
    @IBOutlet var brandLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var stockLabel: UILabel!
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brandLabel.text = product.brand
        titleLabel.text = product.title
        ratingLabel.text = "⭐️ \(product.rating) out of 5 "
        priceLabel.text = "Price: \(product.price) $"
        descriptionLabel.text = product.description
        stockLabel.text = ("In stock: \(product.stock > 0 ? "\(product.stock)" : "Out of stock")")
        configure(with: product)
    }
    
    //MARK: - Private methods
    
    private func configure(with product: Product) {
        
        NetworkManager.shared.fetchImage(from: product.images.randomElement()) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.productImage.image = UIImage(data: imageData)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}


