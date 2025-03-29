//
//  ProductsCollectionViewDataSource.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import UIKit
import SkeletonView

final class ProductsCollectionViewDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var getData: ((_ page: Int) -> Void)?
    var cellAction: ((_ index: Int) -> Void)?
    
    private let viewModel: ProductsViewModel
    
    private var isGrid: Bool {
        viewModel.collectionType == .grid
    }
    
    init(viewModel: ProductsViewModel) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        isGrid ? setupGridCell(collectionView, at: indexPath) : setupListCell(collectionView, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellAction?(indexPath.row)
    }
    
    private func setupGridCell(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(with: ProductsGridCollectionViewCell.self, for: indexPath)
        cell.configureCell(with: viewModel.cellData(at: indexPath.row))
        return cell
    }
    
    private func setupListCell(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(with: ProductsListCollectionViewCell.self, for: indexPath)
        cell.configureCell(with: viewModel.cellData(at: indexPath.row))
        return cell
    }
}

extension ProductsCollectionViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // MARK: - The API Request not have page number in requests for the pagination.
        /// This code is the pagination implementation when has page in the api requests
        let contentHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        let height = scrollView.frame.size.height
        guard (contentHeight - scrollOffset <= height),
              !viewModel.isCollectionLoading,
              viewModel.lastPage > viewModel.currentPage else { return }
        viewModel.isCollectionLoading = true
        getData?(viewModel.currentPage + 1)
    }
}

// MARK: - Setup Collection View Layouts
extension ProductsCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        isGrid ?
            .init(width: (collectionView.frame.width / 2) - 30, height: 250) :
            .init(width: collectionView.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 20, bottom: 0, right: 20)
    }
}

// MARK: - Setup Collection Skeleton Display Implementation
extension ProductsCollectionViewDataSource: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        isGrid ?  ProductsGridCollectionViewCell.reuseIdentifier : ProductsListCollectionViewCell.reuseIdentifier
    }
}
