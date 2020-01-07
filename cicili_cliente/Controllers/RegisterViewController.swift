//
//  RegisterViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 03/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        userTextField.becomeFirstResponder()
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        if let username = userTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty, let phone = phoneTextField.text, !phone.isEmpty, let confirmpassword = confirmPasswordTextField.text, !confirmpassword.isEmpty {
            RequestManager.fetchRegisterClient(parameters: [WSKeys.parameters.PEMAIL: username, WSKeys.parameters.PPASSWORD: password, WSKeys.parameters.PCELLPHONE: phone], success: { response in
                       
                       if response != nil{
                           print("En success y token no nil \(response)")
                           self.userTextField.text = ""
                           self.passwordTextField.text = ""
                           //self.performSegue(withIdentifier: Constants.Storyboard.loginSegueId, sender: self)
                           let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainStoryboard")
                           self.present(vc!, animated: true, completion: nil)
                           
                           }
                       })
                       { error in
                           self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
                       }
               } else {
                   self.showAlertController(tittle_t: Constants.ErrorTittles.titleRequerido, message_t: Constants.ErrorMessages.messageDatosRequeridos)
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