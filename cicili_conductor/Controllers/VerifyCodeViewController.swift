//
//  VerifyCodeViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 05/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class VerifyCodeViewController: UIViewController {

    @IBOutlet weak var codeTextField: UITextField!
    
    var token : String?
    var sEmail: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Regresar", style: .plain, target: self, action: #selector(handleCancel))
        
        codeTextField.becomeFirstResponder()
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
               view.addGestureRecognizer(gesture)
    }
    
    @objc func handleCancel() {
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func verifyCodeButton(_ sender: UIButton) {
        
        if let codeInput = codeTextField.text, !codeInput.isEmpty {
            RequestManager.fetchValidateCodeRegister(parameters: [WSKeys.parameters.CODIGO: codeInput], success: { response in
                                  
                    if response.codeError == WSKeys.parameters.okresponse {
                        print("En success verifyCodeButton \(response)")
                        //self.sEmail = response.data.correoElectronico
                        self.codeTextField.text = ""
                        self.customAlertController(tittle_t: Constants.AlertTittles.tCodeVerificationSuccess, message_t: Constants.AlertMessages.codeVerificationSuccess, buttonAction: Constants.textAction.actionSignIn, doHandler: self.goLogin)
                    }
                    else{
                        self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: Constants.ErrorMessages.messageVerificaCodigo )
                    }
                })
                { error in
                    self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
                }
        } else {
                self.showAlertController(tittle_t: Constants.ErrorTittles.titleRequerido, message_t: Constants.ErrorMessages.messageDatosRequeridos)
                }
        }
           
        
        func goLogin(action: UIAlertAction){
            /*guard let loginController = self.storyboard?.instantiateViewController(
                withIdentifier: "LoginStoryboard") as? ViewController else {
                fatalError("Unable to create LoginViewController")
            }
            
            self.present(loginController, animated: true, completion: nil)*/
            
            self.performSegue(withIdentifier: Constants.Storyboard.registerPasswordSegue, sender: self)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
   
        if segue.identifier ==  Constants.Storyboard.registerPasswordSegue{
            let newOrderController = segue.destination as! PasswordRegisterViewController
            newOrderController.lblEmail.text = self.sEmail
            
            
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
