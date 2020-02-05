//
//  CardOrderViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 05/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
import ObjectMapper

class CardOrderViewController: UIViewController {
    
    var cliente : Cliente?
    var orderResponse = NewOrder()
    var selectedAddress : Int = 0
    var selectedLatitud : Double = 0.0
    var selectedLongitud : Double = 0.0
    var selectedDriver : Int = 0
    var selectedOrderIn : String = ""
    var selectedPayForm : String = ""
    var messageerror : String = ""
    var delegate : DataDelegate?
    var driverObject = NearDrivers()
    
    @IBOutlet weak var handleArea: UIView!
    
    @IBOutlet weak var btnOrder: RoundButton!
    @IBOutlet weak var lblLiter: UILabel!
    @IBOutlet weak var lblAmmount: UILabel!
    @IBOutlet weak var textfieldPrice: UITextField!
    @IBOutlet weak var textfieldAmmount: UITextField!
    @IBOutlet weak var segmentedPaymentType: UISegmentedControl!
    @IBOutlet weak var segmentedOrderType: UISegmentedControl!
    @IBOutlet weak var lblCoName: UILabel!
    
    @IBOutlet weak var lblArriveTime: UILabel!
    @IBOutlet weak var lblLtPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
                      view.addGestureRecognizer(gesture)
               
    }

    @IBAction func segmentOrderInChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex
        {
            case 0:
                selectedOrderIn = WSKeys.parameters.monto
                textfieldAmmount.placeholder = Constants.textAction.orderInMonto
                textfieldPrice.placeholder = Constants.textAction.orderInLitros
                lblAmmount.text = Constants.textAction.orderInMonto
                lblLiter.text = Constants.textAction.orderInLitros
            case 1:
                selectedOrderIn = WSKeys.parameters.cantidad
                textfieldAmmount.placeholder = Constants.textAction.orderInLitros
                textfieldPrice.placeholder = Constants.textAction.orderInMonto
                lblAmmount.text = Constants.textAction.orderInLitros
                lblLiter.text = Constants.textAction.orderInMonto
            default:
                selectedOrderIn = ""
            break
        }
    }
    
    @IBAction func changueOrderIn(_ sender: UITextField) {
        if let newValue = Double(sender.text!), newValue > 0.0{
            debugPrint("Has CHANGED NO EMPTY")
            debugPrint(newValue)
            switch segmentedOrderType.selectedSegmentIndex
            {
             case 0:
                selectedOrderIn = WSKeys.parameters.monto
                let ammount = Double(textfieldAmmount.text!)
                let calc = ammount! / driverObject.precio
                 textfieldPrice.text = "\(calc)"
                
                if ammount! < 200.00{
                    showAlertController(tittle_t: Constants.ErrorTittles.titleRequeridoMin,
                                                             message_t: Constants.ErrorMessages.messageCantidadMin)
                    textfieldAmmount.text = ""
                    textfieldPrice.text = ""
                }
             case 1:
                 selectedOrderIn = WSKeys.parameters.cantidad
                 let ammount = Double(textfieldAmmount.text!)
                 let calc = ammount! * driverObject.precio
                textfieldPrice.text = "\(calc)"
                
                 if calc < 200.00{
                                   showAlertController(tittle_t: Constants.ErrorTittles.titleRequeridoMin,
                                                                            message_t: Constants.ErrorMessages.messageCantidadMin)
                                   textfieldAmmount.text = ""
                                    textfieldPrice.text = ""
                               }
             default:
                 selectedOrderIn = ""
                break
            }
        }
        else {
            showAlertController(tittle_t: Constants.ErrorTittles.titleRequerido,
                                          message_t: Constants.ErrorMessages.messageCantidad)
        }
        
        
    }
    @IBAction func btnOrder(_ sender: RoundButton) {
        var monto : Double = 0.0
        var litros : Double = 0.0
        
        if let ammount =  Double(textfieldAmmount.text!), ammount > 0.0, let price =  Double(textfieldPrice.text!), price > 0.0 {
            
            switch segmentedOrderType.selectedSegmentIndex
            {
             case 0:
                 selectedOrderIn = WSKeys.parameters.monto
                 monto = Double(textfieldAmmount.text!)!
                 litros = Double(textfieldPrice.text!)!
               
             case 1:
                 selectedOrderIn = WSKeys.parameters.cantidad
                  monto = Double(textfieldPrice.text!)!
                  litros = Double(textfieldAmmount.text!)!
                break
            default:
                selectedOrderIn = ""
                textfieldAmmount.text = ""
                textfieldPrice.text = ""
            }
            
            switch segmentedPaymentType.selectedSegmentIndex
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
            
                debugPrint("En success requestorder \(response)")
                self.orderResponse = response
                self.messageerror = ""
                self.delegate?.sendData(data:self.messageerror)
                
                
            })
            { error in
                debugPrint("---ERROR setOrderData---")
                //self.showAlertController(tittle_t: Constants.ErrorTittles.titleErrorOrder, message_t: error.localizedDescription)
                self.messageerror = error.localizedDescription
                
                self.delegate?.sendData(data:self.messageerror)
                
                //self.dismiss(animated: true, completion: nil)
                
                /*self.performSegue(withIdentifier: Constants.Storyboard.newOrderSegueId, sender: self)*/
                 let panGestureCOBtn = UIPanGestureRecognizer(target: self, action: #selector(MainViewController.handleCardPan(recognizer:)))
        
                self.btnOrder.addGestureRecognizer(panGestureCOBtn)

            }
            
        }
        else{
            showAlertController(tittle_t: Constants.ErrorTittles.titleRequerido,
                                message_t: Constants.ErrorMessages.messageCantidad)
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

}
