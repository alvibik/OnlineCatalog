//
//  ProductTVCell.swift
//  OnlineCatalog
//
//  Created by albik on 14.11.2022.
//

import UIKit

final class ProductTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet var productThumbnailImage: UIImageView!
    @IBOutlet var productTitleLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    @IBOutlet var productDiscountLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public methods
    
    func configure(with product: Product) {
        productTitleLabel.text = product.title
        productPriceLabel.text = "Price: \(product.price ?? 0) $"
        productDiscountLabel.text = "⭐️ \(product.rating ?? 0) out of 5 "
        
        NetworkManager.shared.fetchData(from: product.thumbnail ?? "") { result in
            switch result {
            case .success(let imageData):
                self.productThumbnailImage.image = UIImage(data: imageData)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
