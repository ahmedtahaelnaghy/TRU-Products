//
//  UICollectionView+Configuration.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let identifier = String(describing: T.self)
        self.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func dequeue<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Error in cell")
        }
        return cell
    }
}
