//
//  ProductDetailsViewController.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import UIKit

final class ProductDetailsViewController: BaseViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var productImageHeight: NSLayoutConstraint!
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productRateLabel: UILabel!
    @IBOutlet private weak var productsPriceLabel: UILabel!
    @IBOutlet private weak var productCategoryLabel: UILabel!
    @IBOutlet private weak var productsDescriptionLabel: UILabel!
    
    private let product: ProductsEntity
    
    init(product: ProductsEntity) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - Setup Views and Data
private extension ProductDetailsViewController {
    func setupViews() {
        scrollView.delegate = self
        setupScreenData()
        isNavigationHidden(false)
    }
    
    func setupScreenData() {
        productImage.loadImage(product.image)
        productNameLabel.text = product.title
        productRateLabel.text = product.rating?.rate?.string
        productCategoryLabel.text = product.category
        productsPriceLabel.text = product.price?.string.addCurrency
        productsDescriptionLabel.text = product.description
    }
}

// MARK: - Setup UIScrollViewDelegate For Stretch Image
extension ProductDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        productImageHeight.constant = (offsetY < 0) ? (350 - offsetY) : 350
    }
}
