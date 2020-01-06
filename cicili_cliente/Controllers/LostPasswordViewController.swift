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

        // Do any additional setup after loading the view.
    }
    

    @IBAction func validateCode(_ sender: UIButton) {
        
        if let username = userTextField.text, !username.isEmpty {
            debugPrint(username)
            RequestManager.fetchRequestPassword(parameters: [WSKeys.parameters.PUSERNAME: username], success: { response in
            
                if response.data != nil{
                print("En success y token no nil \(response)")
                self.userTextField.text = ""
                //self.performSegue(withIdentifier: Constants.Storyboard.loginSegueId, sender: self)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainStoryboard")
                self.present(vc!, animated: true, completion: nil)
                
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
