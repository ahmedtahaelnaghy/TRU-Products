//
//  String+Extension.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import Foundation

extension String {
    var double: Double? {
        return Double(self)
    }
    
    var addCurrency: String {
        return "\(self.double?.rounded(toPlaces: 1) ?? 0.0) \(Constants.currency)"
    }
}
