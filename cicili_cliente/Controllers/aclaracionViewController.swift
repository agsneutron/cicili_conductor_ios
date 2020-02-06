//
//  aclaracionViewController.swift
//  cicili_cliente
//
//  Created by guillermo sanchez on 01/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import Foundation
import UIKit
var selectedCategory: String?
var categoryList = ["Pedidos", "Seguridad", "Uso de la App", "Pagos", "Regitro", "Mis preguntas"]

class aclaracionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var aclaracionText: UITextField!
    
    @IBAction func closeButton(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
      createPickerView()
           dismissPickerView()

    }

    func createPickerView() {
           let pickerView = UIPickerView()
           pickerView.delegate = self
           aclaracionText.inputView = pickerView
    }
    func dismissPickerView() {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
       let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
       aclaracionText.inputAccessoryView = toolBar
    }
    @objc func action() {
          view.endEditing(true)
    }
    
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // number of session
        }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryList.count // number of dropdown items
        }
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryList[row] // dropdown item
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categoryList[row] // selected item
        aclaracionText.text = selectedCategory
        }
}
