//
//  LostPasswordViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 05/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class LostPasswordViewController: UIViewController {

    @IBOutlet weak var codeTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func validateCode(_ sender: UIButton) {
        
        if let code = codeTextField.text, !code.isEmpty {
            
            self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: Constants.ErrorMessages.messageVerificaCodigo)
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
