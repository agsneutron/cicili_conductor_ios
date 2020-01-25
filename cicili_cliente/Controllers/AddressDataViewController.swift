//
//  AddressDataViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 11/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
import ObjectMapper

extension UITextField {
    func callAddressTable(selfV : AddressDataViewController, selector: Selector) {
        
        let townView = selfV.storyboard?.instantiateViewController(withIdentifier: "SuburbsViewControllerID") as! SuburbsViewController
        
        townView.delegate=selfV
        selfV.navigationController?.pushViewController(townView, animated: true)
    }
}

class AddressDataViewController:  UIViewController, UITextFieldDelegate {

    @IBOutlet weak var preselectedSwitch: UISwitch!
    @IBOutlet weak var townTextField: UITextField!
    @IBOutlet weak var intNumberTextField: UITextField!
    @IBOutlet weak var extNumberTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    @IBOutlet weak var AliasTextField: UITextField!
    
    
    var cliente: Cliente?
    var suburbsObj: DataByZipCode?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        AliasTextField.becomeFirstResponder()
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
                      view.addGestureRecognizer(gesture)
        
        intNumberTextField.delegate = self
        extNumberTextField.delegate = self
        streetTextField.delegate = self
        AliasTextField.delegate = self
        zipcodeTextField.delegate = self
       
        AliasTextField.tag = 1
        zipcodeTextField.tag = 2
        streetTextField.tag = 3
        extNumberTextField.tag = 4
        intNumberTextField.tag = 5
        
        //self.townTextField.callAddressTable(selfV: self, selector: #selector(tapDone))
               
    }
    

    @objc func tapDone() {
        
        self.townTextField.text=""
        self.townTextField.resignFirstResponder()
    }

    @IBAction func saveAddressButton(_ sender: UIButton) {
        
        if let aliasInput = AliasTextField.text, !aliasInput.isEmpty, let zipcodeInput = zipcodeTextField.text, !zipcodeInput.isEmpty,
            let streetInputInput = streetTextField.text, !streetInputInput.isEmpty,
            let externalInputInput = extNumberTextField.text, !externalInputInput.isEmpty,
            let internalInputInput = intNumberTextField.text, !internalInputInput.isEmpty,
            let townInputInput = townTextField.text, !townInputInput.isEmpty {
        
            let address = Address()
            let asentamiento = Asentamiento()
            
            //asentamiento.cp = Int(zipcodeInput)!
            //asentamiento.estado = ""
            //asentamiento.municipio = ""
            //asentamiento.nombre = ""
            asentamiento.id = townTextField.tag
            asentamiento.text = townTextField.text
            
            address.alias = aliasInput
            address.cp = zipcodeInput
            address.calle = streetInputInput
            address.interior = externalInputInput
            address.exterior = internalInputInput
            address.latitud = 0
            address.longitud = 0
            address.asentamiento = asentamiento
            //address.asentamiento = townInputInput
            
            let objectAsDict:[String : AnyObject] = Mapper<Address>().toJSON(address) as [String : AnyObject]
            
            RequestManager.setAddressData(oauthToken: cliente!.token!, parameters: objectAsDict, success: { response in
                
                if response.codeError == WSKeys.parameters.okresponse{
                    print("En success \(response)")
                    self.AliasTextField.text = ""
                    self.zipcodeTextField.text = ""
                    self.streetTextField.text = ""
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

    @IBAction func hasChangued(_ sender: UITextField) {
        debugPrint("Has CHANGED")
        debugPrint(sender)
        if let zipCodeInput = sender.text, !zipCodeInput.isEmpty{
            debugPrint("Has CHANGED NO EMPTY")
            debugPrint(zipCodeInput)
            if zipCodeInput.count > 4{
                debugPrint("Has CHANGED BIGTHAN4")
                debugPrint(zipCodeInput.count)
                RequestManager.fetchZipCode(oauthToken: cliente!.token!, codeToVerify: zipCodeInput, success: { response in
                    print("En success get zipcode  data \(response.toJSONString(prettyPrint: true))")
                    if response.asentamientos!.count > 0 {
                        self.suburbsObj = response
                    }
                    else{
                        self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerificaCP, message_t: Constants.ErrorMessages.messageVerificaCP)
                    }
                    
                })
                { error in
                    self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
                }
            }
        }
    }
    

    
    
    @IBAction func showTableSubirb(_ sender: Any) {
        if self.suburbsObj!.asentamientos!.count > 0 {
            let townView = self.storyboard?.instantiateViewController(withIdentifier: "SuburbsViewControllerID") as! SuburbsViewController
            townView.delegate=self
            townView.suburbsJSON = self.suburbsObj
            self.navigationController?.pushViewController(townView, animated: true)
        }
        else{
            self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerificaCP, message_t: Constants.ErrorMessages.messageVerificaCP)
        }
    }
}

extension AddressDataViewController : SuburbsTableDelegate {
    func addSuburb(suburb: SuburbsTable) {
        self.townTextField.text = suburb.name
        self.townTextField.tag = suburb.id
    }
    
}
