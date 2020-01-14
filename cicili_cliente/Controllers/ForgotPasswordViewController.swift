//
//  ForgotPasswordViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 08/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userInput : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        passwordTextField.becomeFirstResponder()
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(gesture)
    }
    

    @IBAction func changuePasswordButton(_ sender: UIButton) {
        
        self.view.endEditing(true)
       
        if let password = passwordTextField.text, !password.isEmpty, let passwordConfirm = confirmPasswordTextField.text, !passwordConfirm.isEmpty, let userName = userInput, !userName.isEmpty {
                RequestManager.fetchChanguePassword(parameters: [WSKeys.parameters.PUSERNAME: userName, WSKeys.parameters.PPASSWORD: password], success: { response in
                       
                    if !response.data!.isEmpty{
                           print("En success changued password  \(response)")
                           self.confirmPasswordTextField.text = ""
                           self.passwordTextField.text = ""
                           //self.performSegue(withIdentifier: Constants.Storyboard.loginSegueId, sender: self)
                           // self.showAlertController(tittle_t: Constants.AlertTittles.tChangeSuccess, message_t: Constants.AlertMessages.changeSuccess)
                        
                            
                           let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginStoryboard")
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
