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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        codeTextField.becomeFirstResponder()
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
               view.addGestureRecognizer(gesture)
    }
    
    
    
    @IBAction func verifyCodeButton(_ sender: UIButton) {
        
        if let userTokenInput = token, !userTokenInput.isEmpty, let codeInput = codeTextField.text, !codeInput.isEmpty {
            RequestManager.fetchValidateCodeRegister(oauthToken: userTokenInput, codeToVerify:codeInput, success: { response in
                                  
                       if response.data == WSKeys.parameters.okVerification {
                                  print("En success y token no nil \(response)")
                                  self.codeTextField.text = ""
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
