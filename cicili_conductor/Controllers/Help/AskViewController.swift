//
//  AskViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 03/03/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
import ObjectMapper

class AskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
   
   @IBOutlet weak var aclaracionText: UITextField!
   
  
   @IBOutlet weak var textfieldMessage: UITextField!
   
   var selectedCategory: String?
   var categoryList = [ReusableIdText]()
   var selectedCategoryId: Int = 0
   var order : Int = 0
   let appDelegate = UIApplication.shared.delegate as! AppDelegate
   var cliente : Cliente?
  
   override func viewDidLoad() {
   super.viewDidLoad()
    
    

    self.cliente = appDelegate.responseCliente
   navigationController?.setNavigationBarHidden(false, animated: true)
   self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Regresar", style: .plain, target: self, action: #selector(handleCancel))
       
             
            
   let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
   view.addGestureRecognizer(gesture)
       
    RequestManager.fetchClaimType(oauthToken: self.cliente!.token! , success: { response in
   
               print("En success get claim type \(response)")
           for category in response{
               self.categoryList.append(category)
           }
       })
       { error in
          debugPrint("---ERROR---")
       }
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
      let button = UIBarButtonItem(title: "Aceptar", style: .plain, target: self, action: #selector(self.action))
      toolBar.setItems([button], animated: true)
      toolBar.isUserInteractionEnabled = true
      aclaracionText.inputAccessoryView = toolBar
   }
   
   @objc func action() {
         view.endEditing(true)
   }
   
   @objc func handleCancel() {
     navigationController?.popViewController(animated: true)
     navigationController?.setNavigationBarHidden(true, animated: true)
   }
   
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1 // number of session
       }
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return categoryList.count // number of dropdown items
       }
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return categoryList[row].text // dropdown item
       }
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          
           selectedCategoryId = categoryList[row].id
            debugPrint(selectedCategoryId)
           selectedCategory = categoryList[row].text// selected item
           aclaracionText.text = selectedCategory
       }
   
   @IBAction func btnSetAsk(_ sender: RoundButton) {
  
       
       if let message = textfieldMessage.text, !message.isEmpty, selectedCategoryId > 0 {
           let claimData = Claim()
           let category = ReusableIdText()
           category.id = selectedCategoryId
           claimData.idPedido = order
           claimData.aclaracion = message
           claimData.tipoAclaracion = category
           
           debugPrint("order data claim must 0 \(order)")
           
           let objectAsDict:[String : AnyObject] = Mapper<Claim>().toJSON(claimData) as [String : AnyObject]
           RequestManager.setClaimData(oauthToken: self.cliente!.token!, parameters: objectAsDict, success: { response in
           
           if response.codeError == WSKeys.parameters.okresponse{
               print("En success aclaracion response \(response)")
               //self.performSegue(withIdentifier: Constants.Storyboard.loginSegueId, sender: self)
              
               self.customAlertController(tittle_t: Constants.AlertTittles.titleAsk, message_t: Constants.AlertMessages.messageSuccessAsk, buttonAction: Constants.textAction.actionOK, doHandler: self.doBack)
                                         
               
               }
           })
           { error in
               self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
           }
       }
       else{
           showAlertController(tittle_t: Constants.ErrorTittles.titleRequerido, message_t: Constants.ErrorMessages.messageDatosRequeridos)
       }
   }
   
   @IBAction func closeButton(_ sender: Any) {
           dismiss(animated: true, completion: nil)
      }
   
   func doBack(action: UIAlertAction){
                navigationController?.popViewController(animated: true)
                     navigationController?.setNavigationBarHidden(true, animated: true)
            }
   

   
}

