//
//  ProductTVCell.swift
//  OnlineCatalog
//
//  Created by albik on 14.11.2022.
//

import UIKit

final class ProductTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet var productThumbnailImage: UIImageView! {
        didSet{
            productThumbnailImage.layer.cornerRadius = 15
        }
    }
    @IBOutlet var productTitleLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    @IBOutlet var productDiscountLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Private properties
    
    private var imageURL: URL? {
        didSet {
            productThumbnailImage.image = nil
            updateImage()
        }
    }
    
    // MARK: - Public methods
    
    func configure(with product: Product) {
        productTitleLabel.text = product.title
        productPriceLabel.text = "Price: \(product.price) $"
        productDiscountLabel.text = "⭐️ \(product.rating) out of 5 "
        
        imageURL = URL(string: product.thumbnail)
    }
    
    // MARK: - Private methods
    
    private func updateImage() {
        guard let url = imageURL else { return }
        
        getImage(from: url) { [weak self] result in
            switch result {
            case .success(let image):
                if url == self?.imageURL {
                    self?.productThumbnailImage.image = image
                    self?.activityIndicator.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        if let cachedImage = ImageCacheManager.shared.object(forKey: url.absoluteString as NSString) {
            //print ("Image from cache", url.absoluteString)
            completion(.success(cachedImage))
            return
        }
        
        NetworkManager.shared.fetchImage(from: url) { [weak self] result in
            switch result {
            case .success(let imageData):
                guard let uiImage = UIImage(data: imageData) else { return }
                ImageCacheManager.shared.setObject(uiImage, forKey: url.absoluteString as NSString)
                //print ("Image from url", url.absoluteString)
                completion(.success(uiImage))
                self?.productThumbnailImage.image = uiImage
                self?.activityIndicator.stopAnimating()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
