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
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
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
                    
                    let alert = UIAlertController(title:
                    Constants.AlertTittles.tittleValidateCode, message: Constants.AlertMessages.messageValidateCode, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: Constants.textAction.actionCancel, style: .cancel, handler: nil))
                    alert.addTextField(configurationHandler: { textField in
                        textField.placeholder = Constants.AlertMessages.placeholderTextField
                    })

                    
                    alert.addAction(UIAlertAction(title: Constants.textAction.actionOK, style: .default, handler: { action in

                        
                        if let code = alert.textFields?.first?.text  {
                                   //print(" Code = \(code)")
                            if !code.isEmpty{
                                RequestManager.fetchValidateCodePassword(parameters: [WSKeys.parameters.PUSERNAME: username, WSKeys.parameters.PTMPPASSWORD: code], success: { response in
                                    
                                    if response != nil{
                                        print("En success \(response)")
                                        
                                        //self.performSegue(withIdentifier: Constants.Storyboard.loginSegueId, sender: self)
                                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordStoryboard")
                                        self.present(vc!, animated: true, completion: nil)
                                        
                                        }
                                    })
                                    { error in
                                        self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
                                    }
                            } else {
                                self.showAlertController(tittle_t: Constants.ErrorTittles.titleRequerido, message_t: Constants.ErrorMessages.messageRequeridoLogin)
                            }
                            } else {
                                   print("No code entered")
                            }
                        
                    }))


                    self.present(alert, animated: true)
                    
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
}
