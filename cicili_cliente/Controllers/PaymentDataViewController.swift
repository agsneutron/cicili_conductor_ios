//
//  PaymentDataViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 11/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
import ObjectMapper

class PaymentDataViewController: UIViewController {

    @IBOutlet weak var bankTextField: UITextField!
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var cardTextField: UITextField!
    @IBOutlet weak var cardTypeSegment: UISegmentedControl!
    
    var selectedPaymentType: Int = 0
    var cliente: Cliente?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        cardTextField.becomeFirstResponder()
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
               view.addGestureRecognizer(gesture)
        
    }
    
    @IBAction func cardEditingEnd(_ sender: UITextField) {
        
       if let cardInput = cardTextField.text, !cardInput.isEmpty{
            if cardInput.count > 4{
                let binInput = cardInput.index(cardInput.endIndex, offsetBy:4)
                RequestManager.fetchBankData(oauthToken: cliente!.token!, binToVerify: String(cardInput[..<binInput]), success: { response in
                            
                            if response.codeError == WSKeys.parameters.okresponse{
                                print("En success get bank data \(response)")
                                
                               // self.bankTextField.text = response
                               // self.brandTextField.text = response
                    
                                }
                            })
                            { error in
                                self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
                            }
                    } else {
                        self.showAlertController(tittle_t: Constants.ErrorTittles.titleRequerido, message_t: Constants.ErrorMessages.messageCardRequired)
                
                    }
            }
            else{
                self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: Constants.ErrorMessages.messageDatosRequeridos)
            }
            
    }
        
    
    @IBAction func savePAymentDataButton(_ sender: Any) {
        
        self.view.endEditing(true)
        
        switch cardTypeSegment.selectedSegmentIndex
        {
        case 0:
            selectedPaymentType = WSKeys.parameters.TDD
        case 1:
            selectedPaymentType = WSKeys.parameters.TDC
        default:
           break
        }
        
        
        if let cardInput = cardTextField.text, !cardInput.isEmpty, let dateInput = dateTextField.text, !dateInput.isEmpty, let cvvInput = cvvTextField.text, !cvvInput.isEmpty {
            
            let payment = Payment()
            
            payment.tipoPago = selectedPaymentType
            payment.numero = Int64(cardInput)!
            payment.vencimiento = dateInput
            payment.cvv = Int(cvvInput)!
            payment.banco = cvvInput
            payment.tipoTarjeta = dateInput
            
            let objectAsDict:[String : AnyObject] = Mapper<Payment>().toJSON(payment) as [String : AnyObject]
            
            RequestManager.setPaymentData(oauthToken: cliente!.token!, parameters: objectAsDict, success: { response in
                
                if response.codeError == WSKeys.parameters.okresponse{
                    print("En success \(response)")
                    self.cardTextField.text = ""
                    self.dateTextField.text = ""
                    self.cvvTextField.text = ""
                    //self.performSegue(withIdentifier: Constants.Storyboard.loginSegueId, sender: self)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainStoryboard")
                    self.present(vc!, animated: true, completion: nil)
                    
                    }
                })
                { error in
                    self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
                }
        } else {
            self.showAlertController(tittle_t: Constants.ErrorTittles.titleRequerido, message_t: Constants.ErrorMessages.messageRequeridoLogin)
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
