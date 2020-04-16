//
//  ForgotPasswordViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 08/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userInput : String?
    
    var currentUser = Auth.auth().currentUser
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
                       print("En success changued password  \(response)")
                    if !response.data!.isEmpty{
                        
                        self.currentUser?.updatePassword(to: password)
                        { (error) in
                              print("error changued password  \(error)")
                            if error != nil {
                                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                                    switch errorCode {
                                    case .invalidEmail:
                                        self.showAlert(message: ERROR_MSG_INVALID_EMAIL)
                                    default:
                                        self.showAlert(message: ERROR_MSG_UNEXPECTED_ERROR)
                                    }
                                }
                            }
                        }
                        
                           self.confirmPasswordTextField.text = ""
                           self.passwordTextField.text = ""
                           //self.performSegue(withIdentifier: Constants.Storyboard.loginSegueId, sender: self)
                           // self.showAlertController(tittle_t: Constants.AlertTittles.tChangeSuccess, message_t: Constants.AlertMessages.changeSuccess)
                        
                           self.customAlertController(tittle_t: Constants.AlertTittles.tChangeSuccess, message_t: Constants.AlertMessages.changeSuccess, buttonAction: Constants.textAction.actionSignIn, doHandler: self.closeViewController)
                           
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
    
    func goLogin(action: UIAlertAction){
               let storyboardLogin = UIStoryboard(name: "Main", bundle: nil)
               guard let loginController = storyboardLogin.instantiateViewController(
                   withIdentifier: "LoginStoryboard") as? ViewController else {
                   fatalError("Unable to create LoginViewController")
               }
               
               self.present(loginController, animated: true, completion: nil)
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
