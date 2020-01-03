//
//  ViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 17/12/19.
//  Copyright © 2019 CICILI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signIn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        self.view.endEditing(true)
        
            // TODO: Refactor with MVVM
            
            if let username = user.text, !username.isEmpty, let password = password.text, !password.isEmpty {
                RequestManager.fetchSigIn(parameters: ["username": username, "password": password], success: {
                    
                    self.userTextField.text = ""
                    self.passwordTextField.text = ""
                        self.performSegue(withIdentifier: Constants.Storyboard.homeSegueId, sender: self)
                    })
                 { error in
                    sender.stopAnimation()
                    self.showAlert(message: error.localizedDescription)
                }
            } else {
                self.showAlert(message: "Por favor, complete todos los campos.")
            }
        
    }
    
    

}

