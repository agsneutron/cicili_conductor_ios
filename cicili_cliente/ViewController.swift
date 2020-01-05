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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func singIn(_ sender: UIButton) {
    
        self.view.endEditing(true)
        let userText: String = user.text ?? ""
        let passwordText: String = password.text ?? ""
        
        if !userText.isEmpty && !passwordText.isEmpty{
            RequestManager.fetchSignIn(parameters: [WSKeys.parameters.PUSERNAME: userText, WSKeys.parameters.PPASSWORD: passwordText, WSKeys.parameters.PTOKENDISPOSITIVO: "1234"], success: { response in
                
                if response.access_token != nil{
                    print("En success y token no nil \(response.access_token)")
                    self.user.text = ""
                    self.password.text = ""
                    self.performSegue(withIdentifier: Constants.Storyboard.loginSegueId, sender: self)
                    }
                })
                { error in
                    
                    self.showAlert(message: error.localizedDescription)

                }
        } else {
            self.showAlert(message: "Por favor, ingresa usuario y contraseña.")
        }
    }
}

