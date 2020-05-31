//
//  PasswordRegisterViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 23/03/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class PasswordRegisterViewController: UIViewController {

    @IBOutlet weak var aceptoContrato: UISwitch!
    @IBOutlet weak var txtPasswordConfirm: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblEmail: UILabel!
    var sEmail: String=""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblEmail.text = sEmail
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Regresar", style: .plain, target: self, action: #selector(handleCancel))

        txtPassword.becomeFirstResponder()
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    @objc func handleCancel() {
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnPasswordRegister(_ sender: RoundButton) {
        if (!aceptoContrato.isOn){
            showAlert(message: "Debes aceptar las condiciones del contrato")
            return

        }
        self.view.endEditing(true)
        if let password = txtPassword.text, !password.isEmpty, let passwordConfirm = txtPasswordConfirm.text, !passwordConfirm.isEmpty {
            RequestManager.fetchChanguePassword(parameters: [WSKeys.parameters.PUSERNAME: sEmail, WSKeys.parameters.PPASSWORD: password], success: { response in
                           
                        if !response.data!.isEmpty{
                               print("En success changued password  \(response)")
                               self.txtPasswordConfirm.text = ""
                               self.txtPassword.text = ""
                            
                               self.customAlertController(tittle_t: Constants.AlertTittles.tChangeSuccess, message_t: Constants.AlertMessages.codeVerificationSuccess2, buttonAction: Constants.textAction.actionSignIn, doHandler: self.closeViewController)
                               
                               }
                           })
                           { error in
                               self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
                           }
                   } else {
                       self.showAlertController(tittle_t: Constants.ErrorTittles.titleRequerido, message_t: Constants.ErrorMessages.messageRequeridoLogin)
                   }
        }
        
    
    func closeViewController(action: UIAlertAction){
        let controllers = self.navigationController?.viewControllers
         for vc in controllers! {
            print(vc)
           if vc is ViewController {
             _ = self.navigationController?.popToViewController(vc as! ViewController, animated: true)
           }
        }
    }
    
    
    @IBAction func openContract(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constants.Storyboard.contratoSegueID, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
     
     if segue.identifier == Constants.Storyboard.contratoSegueID{
         debugPrint("tocontrato")
         
     }
    }
    
}
