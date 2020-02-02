//
//  CardMapViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 08/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
import ObjectMapper

class CardMapViewController: UIViewController{
    
    var cliente : Cliente?
    var orderResponse = Response()
    var selectedAddress : Int = 0
    var selectedLatitud : Double = 0.0
    var selectedLongitud : Double = 0.0
    var selectedDriver : Int = 0
    var selectedOrderIn : String = ""
    var selectedPayForm : String = ""
    
    
    @IBOutlet weak var lblMontoLitro: UILabel!
    @IBOutlet weak var handleArea: UIView!
    
    @IBOutlet weak var segmentOrderIn: UISegmentedControl!
    @IBOutlet weak var segmentPayForm: UISegmentedControl!
    
    @IBOutlet weak var textFieldAmmount: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
               view.addGestureRecognizer(gesture)
        
        

    }
    
    @IBAction func segmentOrderInChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex
                  {
                   case 0:
                       selectedOrderIn = WSKeys.parameters.monto
                       textFieldAmmount.placeholder = Constants.textAction.orderInMonto
                       lblMontoLitro.text = Constants.textAction.orderInMonto
                   case 1:
                       selectedOrderIn = WSKeys.parameters.cantidad
                       textFieldAmmount.placeholder  = Constants.textAction.orderInLitros
                        lblMontoLitro.text = Constants.textAction.orderInLitros
                   default:
                       selectedOrderIn = ""
                      break
                  }
    }
    
    
    @IBAction func buttonConfirmOrder(_ sender: RoundButton) {
        var monto : Double = 0.0
        var litros : Double = 0.0
        
        if let ammount =  Double(textFieldAmmount.text!), ammount > 0.0 {
            
            switch segmentOrderIn.selectedSegmentIndex
            {
             case 0:
                 selectedOrderIn = WSKeys.parameters.monto
                 monto = ammount
                 litros = 0.0
             case 1:
                 selectedOrderIn = WSKeys.parameters.cantidad
                 litros = ammount
                 monto = 0.0
             default:
                 selectedOrderIn = ""
                break
            }
            
            switch segmentPayForm.selectedSegmentIndex
            {
             case 0:
                 selectedPayForm = WSKeys.parameters.defectivo
             case 1:
                 selectedPayForm = WSKeys.parameters.dtarjeta
             default:
                 selectedPayForm = ""
                break
            }
            
            let addressData = Address()
            addressData.id = selectedAddress
            let order = Order()
            order.cantidad = litros
            order.monto = monto
            order.domicilio = addressData
            order.latitud = selectedLatitud
            order.longitud = selectedLongitud
            order.formaPago = selectedPayForm
            order.idAutotanque = selectedDriver
        
            
            let objectAsDict:[String : AnyObject] = Mapper<Order>().toJSON(order) as [String : AnyObject]
            RequestManager.setOrderData(oauthToken: cliente!.token!, parameters: objectAsDict , success: { response in
            
                debugPrint("En success maisearch \(response)")
                self.orderResponse = response
                self.performSegue(withIdentifier: Constants.Storyboard.newOrderSegueId, sender: self)
        })
        { error in
           debugPrint("---ERROR---")
        }
            
        }
        else{
            showAlertController(tittle_t: Constants.ErrorTittles.titleRequerido,
                                message_t: Constants.ErrorMessages.messageCantidad)
        }
    }
    
     // navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
   
        if segue.identifier ==  Constants.Storyboard.newOrderSegueId{
            let newOrderController = segue.destination as! NewOrderViewController
            newOrderController.cliente = self.cliente
            newOrderController.order = self.orderResponse
            
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
}
