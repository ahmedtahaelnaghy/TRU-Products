//
//  UIViewController+Extension.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import UIKit

extension UIViewController {
    
    func isNavigationHidden(_ status: Bool) {
        navigationController?.setNavigationBarHidden(status, animated: true)
    }
    
    func push(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func showAlert(_ vc: UIViewController, message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        vc.present(alertController, animated: true, completion: nil)
    }
}
