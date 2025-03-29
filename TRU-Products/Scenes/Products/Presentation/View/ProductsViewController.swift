//
//  ProductsViewController.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import UIKit
import SkeletonView

final class ProductsViewController: BaseViewController {
    
    @IBOutlet private weak var productsCollectionView: UICollectionView!
    @IBOutlet private weak var gridButton: UIButton!
    @IBOutlet private weak var listButton: UIButton!
    
    private lazy var viewModel = ProductsViewModel()
    private let refreshControl = UIRefreshControl()
    private var productsDataSource: ProductsCollectionViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindUI()
        getProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isNavigationHidden(true)
    }
    
    @IBAction private func didTapGridProducts(_ sender: Any) {
        guard viewModel.collectionType != .grid else { return }
        setupButtonsStyle(.grid)
    }
    
    @IBAction private func didTapListProducts(_ sender: Any) {
        guard viewModel.collectionType != .list else { return }
        setupButtonsStyle(.list)
    }
}

// MARK: - Setup Views
private extension ProductsViewController {
    func setupViews() {
        setuCollectionView()
        setupButtonsStyle(.grid)
        handleSwipeToRefresh()
    }
    
    func setupButtonsStyle(_ type: CollectionViewTypes) {
        viewModel.collectionType = type
        viewModel.collectionType.setupButton(grid: gridButton, list: listButton)
        productsCollectionView.reloadData()
    }
    
    func setuCollectionView() {
        productsDataSource = .init(viewModel: viewModel)
        productsCollectionView.delegate = productsDataSource
        productsCollectionView.dataSource = productsDataSource
        productsCollectionView.registerCell(ProductsGridCollectionViewCell.self)
        productsCollectionView.registerCell(ProductsListCollectionViewCell.self)
        
        productsDataSource?.cellAction = { [weak self] index in
            guard let self else { return }
            let product = viewModel.cellData(at: index)
            push(ProductDetailsViewController(product: product))
        }
        
        productsDataSource?.getData = { [weak self] page in
            guard let self else { return }
            getProducts(page: page)
        }
    }
    
    func handleSwipeToRefresh() {
        refreshControl.tintColor = .lightGray
        productsCollectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc
    func refreshData() {
        viewModel.currentPage = 1
        getProducts()
    }
}

// MARK: - APIs Request
private extension ProductsViewController {
    func getProducts(page: Int = 1) {
        Task {
            await viewModel.getProducts(page: page)
        }
    }
}

// MARK: - Bind UI
private extension ProductsViewController {
    func bindUI() {
        bindLoading()
        bindReloadViews()
        bindShowError()
    }
    
    func bindLoading() {
        viewModel.$isLoading.sink { [weak self] in
            guard let self else { return }
            $0 ? SkeletonManager.showSkeleton(productsCollectionView) : SkeletonManager.hideSkeleton(productsCollectionView)
        }.store(in: &cancellable)
    }
    
    func bindReloadViews() {
        viewModel.$reloadViews.sink { [weak self] in
            guard let self, $0 else { return }
            viewModel.isCollectionLoading = false
            refreshControl.endRefreshing()
            productsCollectionView.reloadData()
        }.store(in: &cancellable)
    }
    
    func bindShowError() {
        viewModel.$showError.sink { [weak self] error in
            guard let self, let error else { return }
            showAlert(message: error)
        }.store(in: &cancellable)
    }
}
