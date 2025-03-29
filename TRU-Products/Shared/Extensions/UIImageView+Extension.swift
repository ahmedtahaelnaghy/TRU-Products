//
//  UIImageView+Extension.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import UIKit

final class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}

extension UIImageView {
    func loadImage(_ urlString: String?, placeholder: UIImage? = nil) {
        self.image = placeholder
        
        guard let urlString else { return }
        
        if let cachedImage = ImageCache.shared.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else { return }
            ImageCache.shared.setObject(image, forKey: urlString as NSString)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
