//
//  ProductsGridCollectionViewCell.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import UIKit

final class ProductsGridCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productCategoryLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    
    static let reuseIdentifier = "ProductsGridCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(with product: ProductsEntity) {
        productImage.loadImage(product.image)
        productNameLabel.text = product.title
        productCategoryLabel.text = product.category
        productPriceLabel.text = product.price?.string.addCurrency
    }
}
