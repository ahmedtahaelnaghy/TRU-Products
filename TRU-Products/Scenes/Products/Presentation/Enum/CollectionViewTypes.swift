//
//  CollectionViewTypes.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import UIKit

enum CollectionViewTypes {
    case grid
    case list
}

extension CollectionViewTypes {
    func setupButton(grid: UIButton, list: UIButton) {
        let isGrid = (self == .grid)
        grid.tintColor = isGrid ? .main : .mainGray
        list.tintColor = !isGrid ? .main : .mainGray
    }
}
