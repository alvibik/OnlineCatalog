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
    
    //MARK: - Private properties
    
    private var imageURL: URL? {
        didSet {
            productImage.image = nil
            updateImage()
        }
    }
    
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
        imageURL = URL(string: product.images.randomElement() ?? "")

        NetworkManager.shared.fetchImage(from: URL(string: product.images.randomElement() ?? "")!) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.productImage.image = UIImage(data: imageData)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        if let cachedImage = ImageCacheManager.shared.object(forKey: url.absoluteString as NSString) {
            completion(.success(cachedImage))
            return
        }
        
        NetworkManager.shared.fetchImage(from: url) { [weak self] result in
            switch result {
            case .success(let imageData):
                guard let uiImage = UIImage(data: imageData) else { return }
                ImageCacheManager.shared.setObject(uiImage, forKey: url.absoluteString as NSString)
                completion(.success(uiImage))
                self?.productImage.image = uiImage
                self?.activityIndicator.stopAnimating()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateImage() {
        guard let url = imageURL else { return }
        
        getImage(from: url) { [weak self] result in
            switch result {
            case .success(let image):
                if url == self?.imageURL {
                    self?.productImage.image = image
                    self?.activityIndicator.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


