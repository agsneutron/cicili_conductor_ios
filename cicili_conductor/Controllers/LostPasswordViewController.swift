//
//  LostPasswordViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 05/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class LostPasswordViewController: UIViewController {

   
    @IBOutlet weak var userTextField: UITextField!
    var userAccount: String=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Regresar", style: .plain, target: self, action: #selector(handleCancel))
        
        userTextField.becomeFirstResponder()
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
               view.addGestureRecognizer(gesture)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func validateCode(_ sender: UIButton) {
        
        if let username = userTextField.text, !username.isEmpty {
            debugPrint(username)
            RequestManager.fetchRequestPassword(parameters: [WSKeys.parameters.PUSERNAME: username], success: { response in
            
                if response.data != nil{
                    self.userTextField.text = ""
                    self.alertValidateCode(usernameAccount: username, customMessage: Constants.AlertMessages.messageValidateCode, customTitle: Constants.AlertTittles.tittleValidateCode )
                   
                    
                    //let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyStoryboard")
                    ///self.present(vc!, animated: true, completion: nil)
                }
            })
            { error in
                print("seccess but Error \(error)")
                self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
            }
        }
        else {
            self.showAlertController(tittle_t: Constants.ErrorTittles.titleRequerido, message_t: Constants.ErrorMessages.messagRequeridoCodigo)
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
    
    func alertValidateCode(usernameAccount: String, customMessage: String, customTitle: String){
        let alert = UIAlertController(title:
            customTitle, message: customMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.textAction.actionCancel, style: .cancel, handler: nil))
            alert.addTextField(configurationHandler: { textField in textField.placeholder = Constants.AlertMessages.placeholderTextField})
            alert.addAction(UIAlertAction(title: Constants.textAction.actionOK, style: .default, handler: {
                action in
                    if let code = alert.textFields?.first?.text, !code.isEmpty {
                        if !code.isEmpty{
                            RequestManager.fetchValidateCodePassword(parameters: [WSKeys.parameters.PUSERNAME: usernameAccount, WSKeys.parameters.PTMPPASSWORD: code], success: { response in
                                   //success
                                if response.data == WSKeys.parameters.okVerification{
                                    print("En success validated code \(response)")
                                                           
                                    self.userAccount = usernameAccount
                                    self.performSegue(withIdentifier: Constants.Storyboard.segueRecoveryPasswordCode, sender: self)
                                    
                                    /*guard let forgotPasswordController = self.storyboard?.instantiateViewController(
                                    withIdentifier: "ForgotPasswordStoryboard") as? ForgotPasswordViewController else {
                                    fatalError("Unable to create ForgotPasswordController")}
                                    forgotPasswordController.userInput = usernameAccount
                                    self.present(forgotPasswordController, animated: true, completion: nil)*/
                                }
                                })
                                { error in
                                    //self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
                                    alert.dismiss(animated: true, completion: nil)
                                    self.alertValidateCode(usernameAccount: usernameAccount, customMessage: Constants.AlertMessages.messageTryValidateCode, customTitle: Constants.AlertTittles.tittleTryValidateCode )
                                }
                        } else {
                            self.showAlertController(tittle_t: Constants.ErrorTittles.titleRequerido, message_t: Constants.ErrorMessages.messagRequeridoCodigo)
                        }
                                        
                    } else {
                       self.showAlertController(tittle_t: Constants.ErrorTittles.titleRequerido, message_t: Constants.ErrorMessages.messagRequeridoCodigo)
                    }
                               
            }))
            
        self.present(alert, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
   
        if segue.identifier ==  Constants.Storyboard.segueRecoveryPasswordCode{
            let newOrderController = segue.destination as! ForgotPasswordViewController
            newOrderController.userInput = self.userAccount
           
            
            
        }
    }
    @objc func handleCancel() {
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

