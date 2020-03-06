//
//  CancelOrderViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 01/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

protocol DataCancelDelegate {
    func sendData(data : Response?, message: String)
}

class CancelOrderViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    var cancelReasons : [ReusableIdText] = []
    var token: String?
    var orderId: Int?
    var selectedCancelReason: Int = 0
    var reason : String?
    var delegate: DataCancelDelegate?
    @IBOutlet weak var pickerCancel: UIPickerView!
    @IBOutlet weak var handleArea: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
                view.addGestureRecognizer(gesture)
                let texto = ReusableIdText()
                texto.id=0
                texto.text = "Selecciona un motivo"
            
            pickerCancel.delegate = self
            pickerCancel.dataSource = self
            cancelReasons = [texto]
        
    }

    @IBAction func btnCancel(_ sender: RoundButton) {
        
        if (selectedCancelReason != 0) {
            RequestManager.setCancelOrder(oauthToken: token ?? " ", parameters: [WSKeys.parameters.motivo: selectedCancelReason, WSKeys.parameters.pedido: orderId] , success: { response in
                var cancelResponse = Response()
                cancelResponse = response
                debugPrint("En success order cancel \(cancelResponse.data ?? "ERROR AL CANCELAR ORDEN")")
                self.delegate!.sendData(data:cancelResponse, message: self.reason!)
                
            })
            { error in
                debugPrint("---ERROR---")
            }
        }else{
            self.showAlertController(tittle_t: Constants.ErrorTittles.titleRequerido, message_t: Constants.ErrorMessages.messageSelectReason)
        }
               
    }
    
    func loadData (_pOrder: Int, _pCliente: String, _pCancelReasons: [ReusableIdText]){
        self.token = _pCliente
        self.orderId = _pOrder
        self.cancelReasons = _pCancelReasons
        self.pickerCancel.reloadAllComponents()
           
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
        return cancelReasons.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cancelReasons[row].text
    }
    //setpicker selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        
        selectedCancelReason = cancelReasons[row].id
        self.reason = cancelReasons[row].text
    }

}
