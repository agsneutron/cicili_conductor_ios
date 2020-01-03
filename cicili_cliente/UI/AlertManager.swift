//
//  AlertManager.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 03/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//
import UIKit

class AlertManager: NSObject {
  
}

extension UIViewController{
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Cicili",
                                      message: message,
                                      preferredStyle: .alert)
        let defaultButton = UIAlertAction(title: "Aceptar",
                                          style: .default) {(_) in
                                            // your defaultButton action goes here
        }
        
        alert.addAction(defaultButton)
        present(alert, animated: true) {
            // completion goes here
        }
    }
    
    func showAlert(message: String, closure: (() -> Void)?) {
        let alert = UIAlertController(title: "Cicili",
                                      message: message,
                                      preferredStyle: .alert)
        let defaultButton = UIAlertAction(title: "Aceptar",
                                          style: .default) {(_) in
                                            closure!()
        }
        
        alert.addAction(defaultButton)
        present(alert, animated: true) {
            // completion goes here
        }
    }
}
