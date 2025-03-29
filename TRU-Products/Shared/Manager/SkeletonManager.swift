//
//  SkeletonManager.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import UIKit
import SkeletonView

final class SkeletonManager {
    
    static func showSkeleton(_ collectionView: UICollectionView) {
        collectionView.isSkeletonable = true
        collectionView.showAnimatedGradientSkeleton(
            usingGradient: .init(baseColor: .mainLightGray),
            animation: nil,
            transition: .crossDissolve(0.25)
        )
    }
    
    static func hideSkeleton(_ collectionView: UICollectionView) {
        collectionView.stopSkeletonAnimation()
        collectionView.hideSkeleton()
        collectionView.reloadData()
    }
}

