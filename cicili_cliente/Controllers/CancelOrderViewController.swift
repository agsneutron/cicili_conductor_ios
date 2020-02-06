//
//  CancelOrderViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 01/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class CancelOrderViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    var cancelReason : [ReusableIdText] = []
    var token: String?
    var orderId: Int = 0
    var selectedCancelReason: Int = 0
    @IBOutlet weak var pickerCancel: UIPickerView!
    @IBOutlet weak var handleArea: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
               view.addGestureRecognizer(gesture)
        
        self.pickerCancel.delegate = self
        self.pickerCancel.dataSource = self
        
    }

    @IBAction func btnCancel(_ sender: RoundButton) {
        
        RequestManager.setCancelOrder(oauthToken: token ?? " ", parameters: [WSKeys.parameters.motivo: selectedCancelReason, WSKeys.parameters.pedido: orderId] , success: { response in
               
        print("En success get cancel reason \(response)")
                          
        })
        { error in
            debugPrint("---ERROR---")
        }
               
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cancelReason.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cancelReason[row].text
    }
    //sexpicker selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        
        selectedCancelReason = cancelReason[row].id
    }

}
