//
//  AddressDataViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 11/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
import ObjectMapper

class AddressDataViewController: UIViewController {

    @IBOutlet weak var preselectedSwitch: UISwitch!
    @IBOutlet weak var townTextField: UITextField!
    @IBOutlet weak var intNumberTextField: UITextField!
    @IBOutlet weak var extNumberTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    @IBOutlet weak var AliasTextField: UITextField!
    
    var cliente = Cliente?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveAddressButton(_ sender: UIButton) {
        
        if let aliasInput = AliasTextField.text, !aliasInput.isEmpty, let zipcodeInput = zipcodeTextField.text, !zipcodeInput.isEmpty,
            let streetInputInput = streetTextField.text, !streetInputInput.isEmpty,
            let externalInputInput = extNumberTextField.text, !externalInputInput.isEmpty,
            let internalInputInput = intNumberTextField.text, !internalInputInput.isEmpty,
            let townInputInput = townTextField.text, !townInputInput.isEmpty {
        
            let adsress =  Address()
            
            adsress.alias = aliasInput
            adsress.cp = zipcodeInput
            adsress.calle = streetInputInput
            adsress.interior = externalInputInput
            adsress.exterior = internalInputInput
            adsress.asentamiento = townInputInput
            
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

}
