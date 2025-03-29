//
//  ProductsCollectionViewDataSource.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import UIKit
import SkeletonView

final class ProductsCollectionViewDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
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
        let contentHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        let height = scrollView.frame.size.height
        guard (contentHeight - scrollOffset <= height),
              !viewModel.isCollectionLoading,
              viewModel.lastPage > viewModel.currentPage else { return }
        viewModel.isCollectionLoading = true
        getData(page: viewModel.currentPage + 1)
    }
    
    func getData(page: Int) {
        Task {
            await viewModel.getProducts(page: page)
        }
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
