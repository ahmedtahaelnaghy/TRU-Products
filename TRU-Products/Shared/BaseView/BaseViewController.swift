//
//  BaseViewController.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.frame = .init(x: 0, y: 0, width: 80, height: 80)
        indicator.color = UIColor.lightGray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    func startLoading() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.removeFromSuperview()
        activityIndicator.stopAnimating()
    }
}
