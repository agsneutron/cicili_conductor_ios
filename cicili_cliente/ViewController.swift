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
                RequestManager.fetchSignIn(parameters: ["username": username, "password": password], success: {_ in
                    
                    self.user.text = ""
                    self.password.text = ""
                        self.performSegue(withIdentifier: Constants.Storyboard.homeSegueId, sender: self)
                    })
                 { error in
                    
                    self.showAlert(message: error.localizedDescription)
                }
            } else {
                self.showAlert(message: "Por favor, complete todos los campos.")
            }
        
    }
    
    

}

