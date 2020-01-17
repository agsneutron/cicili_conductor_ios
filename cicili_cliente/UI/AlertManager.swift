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
    
    func showAlertController(tittle_t: String, message_t:String){
        let alertController = UIAlertController(title: tittle_t, message: message_t, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Aceptar", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    func customAlertController(tittle_t: String, message_t:String, buttonAction: String, doHandler: @escaping ((_: UIAlertAction) -> Void)){
        let alertController = UIAlertController(title: tittle_t, message: message_t, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: buttonAction, style: .default, handler: doHandler)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func inputAlertController(tittle_t: String, message_t:String, buttonAction: String, doHandler: @escaping ((_: UIAlertAction) -> Void)){
        
        let alertController = UIAlertController(title: tittle_t, message: message_t, preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = Constants.AlertMessages.placeholderTextField})
        let defaultAction = UIAlertAction(title: buttonAction, style: .default, handler: doHandler)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}
