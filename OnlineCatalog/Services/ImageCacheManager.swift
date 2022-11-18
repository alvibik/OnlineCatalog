//
//  ImageCacheManager.swift
//  OnlineCatalog
//
//  Created by albik on 18.11.2022.
//

import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
